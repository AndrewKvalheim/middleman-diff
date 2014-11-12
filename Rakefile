require 'bundler'
require 'rake/clean'

# Gem helpers
Bundler::GemHelper.install_tasks

# Feature tests
begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |cucumber|
    cucumber.cucumber_opts = '--profile ci' if ENV['CI'] == 'true'
  end
rescue
  desc 'Cucumber is not available.'
  task :features do
    abort 'Cucumber is not available.'
  end
end

# All tests
desc 'Run all tests.'
task test: %w(features)

# Default
task default: :test
