# frozen_string_literal: true
require_relative 'omdb_api'

module Movlog
  # Movies search
  class Movies
    attr_reader :movies
    attr_reader :num
    attr_reader :response

    def initialize(data:)
      @movies = parse_movie(data['Search'])
      @num = data['totalResults']
      @response = data['Response']
    end

    def self.find(s:)
      search_result = OmdbApi.search_movie(s)
      new(data: search_result)
    end

    def parse_movie(result)
      result.map do |movie|
        Movie.find(imdb_id: movie['imdbID'], title: movie['Title'],
          year: movie['Year'], poster: movie['Poster'], type: movie['Type']
        )
      end
    end
  end
end
