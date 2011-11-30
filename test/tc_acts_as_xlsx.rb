#!/usr/bin/env ruby -w
require 'test/unit'
require "acts_as_xlsx.rb"
require 'active_record'

require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))

class TestActsAsXlsx < Test::Unit::TestCase

  class Post < ActiveRecord::Base
    acts_as_xlsx :columns=>[:name, :title, :content, :votes, :ranking], :i18n => 'activerecord.attributes'
  end

  def test_xlsx_options
    assert_equal([:name, :title, :content, :votes, :ranking], Post.xlsx_columns)
    assert_equal('activerecord.attributes', Post.xlsx_i18n)
  end

end

class TestToXlsx < Test::Unit::TestCase

  def test_xlsx_columns
    assert_equal( Post.xlsx_columns, Post.column_names.map {|c| c.to_sym})
  end

  def test_to_xslx_vanilla
    p = Post.to_xlsx
    assert_equal("Id",p.workbook.worksheets.first.rows.first.cells.first.value)
    assert_equal(2,p.workbook.worksheets.first.rows.last.cells.first.value)
  end

  def test_columns
    p = Post.to_xlsx :columns => [:name, :title, :content, :votes]
    sheet = p.workbook.worksheets.first
    assert_equal(sheet.rows.first.cells.size, Post.xlsx_columns.size - 3)
    assert_equal("Name",sheet.rows.first.cells.first.value)
    assert_equal(7,sheet.rows.last.cells.last.value)
  end

  def test_method_in_columns
    p = Post.to_xlsx :columns=>[:name, :votes, :content, :ranking]
    sheet = p.workbook.worksheets.first
    assert_equal("Name", sheet.rows.first.cells.first.value)
    assert_equal(Post.last.ranking, sheet.rows.last.cells.last.value)
  end
end


