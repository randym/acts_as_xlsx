require 'rubygems'
require 'test/unit'
require 'axlsx'
require 'active_record'


class TestPackage < Test::Unit::TestCase

  require "axlsx/acts_as_xlsx"

  def test_alive
    assert(true)
  end

end
