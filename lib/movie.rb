# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movie info
  class Movie
    attr_reader :imdb_id

    def initialize(omdb_api, t: nil)
      @omdb_api = omdb_api
      movie = @omdb_api.movie_info(t)
      @imdb_id = movie['imdbID']
    end
  end
end
