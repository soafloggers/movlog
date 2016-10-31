# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/movlog'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"

CASSETTE_FILE_1 = 'omdb_api'
CASSETTE_FILE_2 = 'skyscanner_api'
CASSETTE_FILE_3 = 'airbnb_api'

OMDB_KEYWORD = 'hobbit'

if File.file?('config/credentials.yml')
  credentials = YAML.load(File.read('config/credentials.yml'))
  ENV['AIRBNB_CLIENT_ID'] = credentials[:airbnb_client_id]
  ENV['SKY_API_KEY'] = credentials[:skyscanner_api_key]
end

RESULT_FILE_1 = "#{FIXTURES_FOLDER}/omdb_api_results.yml"
RESULT_FILE_2 = "#{FIXTURES_FOLDER}/skyscanner_api_results.yml"
RESULT_FILE_3 = "#{FIXTURES_FOLDER}/airbnb_api_results.yml"
