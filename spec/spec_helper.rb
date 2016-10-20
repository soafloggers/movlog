# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

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
