# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movie info
  class Movie
    attr_reader :imdb_id

    def initialize(omdb_api, data: nil)
      @omdb_api = omdb_api
      @imdb_id = data['imdbID']
    end

    def self.find(omdb_api, t:)
      movie_data = omdb_api.movie_info(t)
      new(omdb_api, data: movie_data)
    end
  end
end
