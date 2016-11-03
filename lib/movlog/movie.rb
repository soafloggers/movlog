# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movie info
  class Movie
    attr_reader :imdb_id, :title, :year, :actors, :poster, :plot, :location

    def initialize(data:,location:)
      @imdb_id = data['imdbID']
      @title = data['Title']
      @year = data['Year']
      @actors = data['Actors']
      @poster = data['Poster']
      @plot = data['Plot']
      #@location = location
    end

    def self.find(t:)
      movie_data = OmdbApi.movie_info(t)
      imdb_id = movie_data['imdbID']
      location = OmdbApi.location(imdb_id)
      new(data: movie_data,location: location)
    end
  end
end
