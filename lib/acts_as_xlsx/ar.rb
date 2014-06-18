# -*- coding: utf-8 -*-
# Axlsx is a gem or generating excel spreadsheets with charts, images and many other features.
#
# acts_as_xlsx provides integration into active_record for Axlsx.
#
require 'axlsx'

# Adding to the Axlsx module
# @see http://github.com/randym/axlsx
module Axlsx
  # === Overview
  # This module defines the acts_as_xlsx class method and provides to_xlsx support to both AR classes and instances
  module Ar

    def self.included(base) # :nodoc:
      base.send :extend, ClassMethods
    end

    # Class methods for the mixin
    module ClassMethods

      # defines the class method to inject to_xlsx
      # @option options [Array, Symbol] columns an array of symbols defining the columns and methods to call in generating sheet data for each row.
      # @option options [String, Boolean] i18n (default nil) The path to search for localization. When this is specified your i18n.t will be used to determine the labels for columns. If this option is set to true, the default activerecord.attributes scope is always applied, regardless of what is passed in to to_xlsx.
      # @example
      #       class MyModel < ActiveRecord::Base
      #          acts_as_xlsx columns: [:id, :created_at, :updated_at], i18n: 'activerecord.attributes'
      def acts_as_xlsx(options={})
        cattr_accessor :xlsx_i18n, :xlsx_columns
        self.xlsx_i18n = options.delete(:i18n) || false
        self.xlsx_columns = options.delete(:columns)
        extend Axlsx::Ar::SingletonMethods
      end
    end

    # Singleton methods for the mixin
    module SingletonMethods

      # Maps the AR class to an Axlsx package
      # If you are using AR 3.0 or higher, where and order options are used when retrieving models.
      # If you are on an earlier version, any option not listed here is passed into find(:all, options).
      # @param [Array, Array] columns as an array of symbols or a symbol that defines the attributes or methods to render in the sheet.
      # @option options [Integer] header_style to apply to the first row of field names
      # @option options [Array, Symbol] types an array of Axlsx types for each cell in data rows or a single type that will be applied to all types.
      # @option options [Integer, Array] style The style to pass to Worksheet#add_row
      # @option options [String] i18n The path to i18n attributes. (usually activerecord.attributes)
      # @option options [Package] package An Axlsx::Package. When this is provided the output will be added to the package as a new sheet.
      # @option options [String] name This will be used to name the worksheet added to the package. If it is not provided the name of the table name will be humanized when i18n is not specified or the I18n.t for the table name.
      # @option options [Boolean] skip_humanization When true, column names will be used 'as is' in the sheet header and sheet name when she sheet name is not specified.
      # @see Worksheet#add_row
      def to_xlsx(options = {})
        if self.xlsx_columns.nil?
          self.xlsx_columns = self.column_names.map { |c| c = c.to_sym }
        end

        package = options[:package] || Package.new
        write_options = options.clone.merge(xlsx_style(package, options))
        sheet_name = options[:name] || xlsx_label_for(table_name, xlsx_i18n, options[:skip_humanization])

        package.workbook.add_worksheet(name: sheet_name) do |sheet|
          xlsx_write_header sheet, write_options
          xlsx_write_body sheet, write_options
        end

        package
      end

      private

      def xlsx_i18n
        self.xlsx_i18n == true ? 'activerecord.attributes' : options.delete(:i18n) || self.xlsx_i18n
      end

      def xlsx_style(package, options)
        row_style = package.workbook.styles.add_style(options[:style]) if options[:style]
        header_style = package.workbook.styles.add_style(options[:header_style]) if options[:header_style]
        {header_style: header_style, row_style: row_style}
      end

      def xlsx_write_header(sheet, options={})
        namespace = xlsx_i18n ? "#{xlsx_i18n}.#{self.name.underscore}" : false
        columns = options[:columns] || self.xlsx_columns
        column_labels = columns.map do |column|
          xlsx_label_for(column, namespace, options[:skip_humanization])
        end
        sheet.add_row column_labels, :style => options[:header_style]
      end

      def xlsx_write_body(sheet, options={})
        columns = options[:columns] || self.xlsx_columns
        method_chains = columns.map { |column| column.to_s.split('.') }
        types = [*options[:types]]
        xlsx_records(options).map do |record|
          row_data = method_chains.map do |chain|
            chain.reduce(record) do |receiver, method|
              receiver.send(method)
            end
          end
          sheet.add_row row_data, style: options[:row_style], types: types
        end
      end

      def xlsx_records(options={})
        records = [*options.delete(:data)]
        if records.empty?
          if Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('3.0.0')
            records = [*where(options.delete(:where)).order(options.delete(:order))]
          else
            find_options = options.select do |key, value|
              %w(conditions order group limit offset joins include select from readonly lock).include?(key.to_s)
            end
            records = [*find(:all, find_options)]
          end
        end
        records.compact.flatten
      end

      def xlsx_label_for(key, namespace, skip_humanization)
       if namespace
         I18n.t("#{namespace}.#{key}")
       else
         skip_humanization ? key.to_s : key.to_s.humanize
       end
      end
    end
  end
end

require 'active_record'
ActiveRecord::Base.send :include, Axlsx::Ar
