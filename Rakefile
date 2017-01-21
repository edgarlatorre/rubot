require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'tests/**/*_test.rb'
end

desc 'Run without an application server'
task :run do
  ruby 'app.rb'
end

task default: :test
