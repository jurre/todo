#!/usr/bin/env rake

require "rspec/core/rake_task"

desc "run specs"
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :app do
  require "./app"
end

Dir[File.dirname(__FILE__) + "/lib/tasks/*.rb"].sort.each do |path|
  require path
end
