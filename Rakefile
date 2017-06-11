# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/test_*.rb'
end

task :rubocop do
  sh 'bundle exec rubocop'
end

task all: %i[rubocop test]
