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
      # @option options [Array, Symbol] exclude a list of columns to exclude from the report
      # @option options [Array, Symbol] include a list of associated models to include in the report
      # @option options [String] i18n (default nil) The path to search for localization. When this is specified your i18n.t will be used to determine the labels for columns.
      # @option options [Boolean] attributes_only (default false) By default, acts_as_xlsx will use methods on your model over attributes with the same name. If you want to restrict the behavior to only using active record instance attributes when generating xlsx set this to true
      # @option options [Array, Symbol] A list of method names that will be called. the name of the method will be the column. The return value will be applied for each row. 
      # @example
      #       class MyModel < ActiveRecord::Base
      #          acts_as_xlsx :exclude => [:id, :created_at, :updated_at], :i18n => 'activerecord.attributes'
      def acts_as_xlsx(options={})
        cattr_accessor :xlsx_options, :xlsx_columns, :xlsx_labels
        self.xlsx_options = options
        include Axlsx::Ar::InstanceMethods        
        extend Axlsx::Ar::SingletonMethods
      end
    end

    # Singleton methods for the mixin
    module SingletonMethods

      # Maps the AR class to an Axlsx package
      # options are passed into AR find
      # @param [Symbol, Integer] :all, :first, id etc.
      # @option options [Integer] header_style to apply to the first row of field names
      # @option options [Array, Symbol] an array of Axlsx types for each cell in data rows or a single type that will be applied to all types.
      # @option options [Integer, Array] style The style to pass to Worksheet#add_row
      # @option options [Array] reject The names fo columns to exclude from the report
      # @see Worksheet#add_row
      def to_xlsx(number = :all, options = {})
        row_style = options.delete(:style)
        header_style = options.delete(:header_style) || row_style
        types = options.delete(:types)
        xlsx_options[:reject] << options.delete(:reject) unless options[:reject].nil?
        

        p = Package.new
        row_style = p.workbook.styles.add_style(row_style) unless row_style.nil?
        header_style = p.workbook.styles.add_style(header_style) unless header_style.nil?

        data = [*find(number, options)]
        data.compact!
        data.flatten!
        return p if data.empty?
        @xlsx_columns = data.first.attributes.keys - @xlsx_reject.map { |r| r = r.to_s }
        p.workbook.add_worksheet(:name=>table_name.humanize) do |sheet|
          col_labels = @i18n == false ? @xlsx_columns : @xlsx_columns.map { |c| I18n.t("#{@i18n}.#{self.name.underscore}.#{c}") }
          
          sheet.add_row col_labels, :style=>header_style
          data.each do |r|
            row_data = @xlsx_columns.map { |c| r.attributes[c] }
            sheet.add_row row_data, :style=>row_style, :types=>types
          end
        end
        p
      end
    end

    # Empty module - I really like ruports way of allowing :include, :only, :exclude 
    # and am looking to add something like that in the next release
    module InstanceMethods

      # Allows a single instance to be exported
      # All active record find options are allowed
      def to_xlsx(options={})
        self.class.to_xlsx(self.id, options)
      end
    end
    

  end

end

begin

require 'active_record'
ActiveRecord::Base.send :include, Axlsx::Ar


