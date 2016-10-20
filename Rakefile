# frozen_string_literal: true
require 'rake/testtask'

namespace :spec do
  desc 'run all tests'
  task all: [:omdb, :skyscanner, :airbnb]

  task :omdb do
    sh 'ruby spec/omdb_spec.rb'
  end

  task :skyscanner do
    sh 'ruby spec/skyscanner_spec.rb'
  end

  task :airbnb do
    sh 'ruby spec/airbnb_spec.rb'
  end
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No cassettes found')
  end
end

namespace :quality do
  desc 'run all quality checks'
  task all: [:rubocop, :flog, :flay]

  task :flog do
    sh 'flog lib/'
  end

  task :flay do
    sh 'flay lib/'
  end

  task :rubocop do
    sh 'rubocop'
  end
end
