require 'rake'
acts_as_xlsx_version = "1.0.1"
Gem::Specification.new do |s|
  s.name        = 'acts_as_xlsx'
  s.version     =  acts_as_xlsx_version
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

  s.files = FileList.new('*', 'lib/**/*', 'doc/**/*', 'test/**/*', 'examples/**/*') do |fl|
    fl.exclude("*.*~")
    fl.exclude(".*")
    fl.exclude("todo")
    fl.exclude("*.gem")
    fl.exclude("*.xlsx")
  end

  s.add_runtime_dependency 'axlsx', '>= 1.0.10'
  s.add_runtime_dependency 'activerecord', '>= 2.3.9'
  s.add_runtime_dependency 'i18n', '>=0.6.0'

  # required for yard documentation generation
  s.add_runtime_dependency 'yard'
  s.add_runtime_dependency 'rdiscount'
  
  # required for running tests
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rake', '>= 0.9.2'

end
