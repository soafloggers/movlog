# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movie info
  class Movie
    attr_reader :imdb_id, :type, :title, :year, :poster
    attr_reader :rating, :plot, :runtime
    attr_reader :awards, :director, :actors
    attr_reader :country, :language
    attr_reader :response
    attr_reader :location

    def initialize(data:)
      @imdb_id = data[:imdb_id]
      @title = data[:title]
      @year = data[:year]
      @type = data[:type]
      @poster = data[:poster]
    end

    def self.find(data)
      new(data: data)
    end

    def get_location
      return @location if @location
      @location = OmdbApi.location(@imdb_id)
    end

    def get_details
      movie_details = OmdbApi.movie_info(@title)
      parse_details(details: movie_details)
    end

    def parse_details(details:)
      @rating = details['imdbRating']
      @plot = details['Plot']
      @runtime = details['Runtime']
      @awards = details['Awards']
      @director = details['Director']
      @actors = details['Actors']
      @country = details['Country']
      @language = details['Language']
    end
  end
end
