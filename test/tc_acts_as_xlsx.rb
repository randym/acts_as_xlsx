#!/usr/bin/env ruby -w
require 'test/unit'
require "axlsx/acts_as_xlsx"
require 'active_record'

require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))

load_schema

class TestClassAttributes < Test::Unit::TestCase
    class Post < ActiveRecord::Base
      acts_as_xlsx :reject =>:id, :includes =>:comment, :methods => [:ranking, :last_comment]
    end

  def test_xlsx_options
    assert_equal({:reject=>[:id], :includes=>[:comment], :methods=>[:ranking, :last_comment]}, Post.xlsx_options)
  end
  def test_xlsx_columns
    assert_equal(nil, Post.xlsx_columns)
  end
  def test_xlsx_labels
    assert_equal(nil, Post.xlsx_labels)
  end
end

class TestVanillaToXlsx < Test::Unit::TestCase
  

  def test_to_xslx_standard
    p = Post.to_xlsx(:all)
    assert(Post.first.comments.size == 1)
    assert(Post.last.comments.size == 2)
    assert("first_post",p.workbook.worksheets.first.rows.first.cells.first.value)
    assert(1,p.workbook.worksheets.last.rows.last.cells.last.value)
  end
end

class TestRejection < Test::Unit::TestCase
  def test_reject
    p = Post.to_xlsx(:all, :reject=>:id)
    assert(Post.first.comments.size == 1)
    assert(Post.last.comments.size == 2)

    assert("first_post",p.workbook.worksheets.first.rows.first.cells.first.value)
    assert(1,p.workbook.worksheets.last.rows.last.cells.last.value)
  end

end

