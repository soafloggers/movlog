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

# FIXTURES_FOLDER = 'spec/fixtures'
# CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
# CASSETTE_FILE = '_api'
CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
# RESULT_FILE = "#{FIXTURES_FOLDER}/fb_api_results.yml"
