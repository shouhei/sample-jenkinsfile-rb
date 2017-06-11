require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/test_*.rb'
end

task :rubocop do
  sh 'rubocop'
end

task all: [:rubocop, :test]
