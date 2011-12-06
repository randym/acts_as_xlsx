require 'rake'
require File.expand_path(File.dirname(__FILE__) + '/lib/acts_as_xlsx/version.rb')

Gem::Specification.new do |s|
  s.name        = 'acts_as_xlsx'
  s.version     =  Axlsx::Ar::VERSION
  s.author	= "Randy Morgan"
  s.email       = 'digital.ipseity@gmail.com'
  s.homepage 	= 'https://github.com/randym/acts_as_xlsx'
  s.platform    = Gem::Platform::RUBY       	     	  
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = "ActiveRecord support for Axlsx"
  s.has_rdoc    = 'acts_as_xlsx'
  s.description = <<-eof
    acts_as_xlsx lets you turn any ActiveRecord::Base inheriting class into an excel spreadsheet.
  eof
  # s.files 	= Dir.glob("{doc,lib,test,schema,examples}/**/*") + %w{ LICENSE README.md Rakefile CHANGELOG.md }

  s.files = FileList.new('*', 'lib/**/*', 'doc/**/*', 'examples/**/*') do |fl|
    fl.exclude("*.*~")
    fl.exclude(".*")
    fl.exclude("todo")
    fl.exclude("*.gem")
    fl.exclude("*.xlsx")
  end

  s.test_files = FileList.new('test/**/*') do |fl|
      fl.exclude("*.*~")
      fl.exclude("*.db")
  end	       

  s.add_runtime_dependency 'axlsx', '>= 1.0.10'
  s.add_runtime_dependency 'activerecord', '>= 2.3.9'
 
  # pinning rake to see if it solves some bundler exec rake problems with recursive includes
  s.add_development_dependency 'rake', "0.8.7"  if RUBY_VERSION == "1.9.2"
  s.add_development_dependency 'rake', "~> 0.9"#  if ["1.9.3", "1.8.7"].include?(RUBY_VERSION)
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rdiscount'

  s.required_ruby_version = '>= 1.8.7'
  s.require_path = 'lib'

end
