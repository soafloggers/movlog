require 'http'

module Movlog
  class Movie
    attr_reader :imdb_id

    def initialize(keyword:)
      movie_response = HTTP.get(
        'http://www.omdbapi.com',
        params: {
          t: keyword,
          y: '',
          plot: 'short',
          r: 'json'
        })

      movie = JSON.load(movie_response.to_s)
      @imdb_id = movie['imdbID']
    end
  end
end
