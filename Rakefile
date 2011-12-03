require File.expand_path(File.dirname(__FILE__) + '/lib/acts_as_xlsx/version.rb')

task :build => :gendoc do
  system "gem build acts_as_xlsx.gemspec"
end

task :gendoc do   
  system "yardoc"
end

task :test do 
     require 'rake/testtask'
     Rake::TestTask.new do |t|
       t.libs << 'test'
       t.test_files = FileList['test/**/tc_*.rb']
       t.verbose = true
     end
end

task :release => :build do
  system "gem push acts_as_xlsx-#{Axlsx::Ar::VERSION}.gem"
end

task :default => :test