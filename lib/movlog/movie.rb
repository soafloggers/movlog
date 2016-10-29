# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movie info
  class Movie
    attr_reader :imdb_id, :title, :year, :actors, :poster, :plot

    def initialize(data:)
      @imdb_id = data['imdbID']
      @title = data['Title']
      @year = data['Year']
      @actors = data['Actors']
      @poster = data['Poster']
      @plot = data['Plot']
    end

    def self.find(t:)
      movie_data = OmdbApi.movie_info(t)
      new(data: movie_data)
    end
  end
end
