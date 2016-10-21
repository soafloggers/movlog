# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/omdb_api'
require_relative '../lib/movie.rb'
require_relative '../lib/airbnb_api'
require_relative '../lib/room.rb'
require_relative '../lib/skyscanner_api'
require_relative '../lib/routes.rb'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"

CASSETTE_FILE_1 = 'omdb_api'
CASSETTE_FILE_2 = 'skyscanner_api'
CASSETTE_FILE_3 = 'airbnb_api'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))

RESULT_FILE_1 = "#{FIXTURES_FOLDER}/omdb_api_results.yml"
RESULT_FILE_2 = "#{FIXTURES_FOLDER}/skyscanner_api_results.yml"
RESULT_FILE_3 = "#{FIXTURES_FOLDER}/airbnb_api_results.yml"
