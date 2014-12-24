#!/usr/bin/env rake

task :console do
  require 'irb'
  require 'irb/completion'
  require 'mutability'
  ARGV.clear
  IRB.start
end

task :release do
  `bundle exec gem release --tag`
end
