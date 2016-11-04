# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movie info
  class Movie
    attr_reader :imdb_id, :title, :year, :actors, :poster, :plot, :location
    attr_reader :response
    
    def initialize(data:)
      @imdb_id = data['imdbID']
      @title = data['Title']
      @year = data['Year']
      @actors = data['Actors']
      @poster = data['Poster']
      @plot = data['Plot']
      @response = data['Response']
    end

    def self.find(t:)
      movie_data = OmdbApi.movie_info(t)
      new(data: movie_data)
    end

    def get_location
      return @location if @location
      @location = OmdbApi.location(@imdb_id)
    end
  end
end
