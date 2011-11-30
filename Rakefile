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

task :default => :test