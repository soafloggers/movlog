# frozen_string_literal: true
require 'http'
require 'json'

module Movlog
  # Service for all OMDB API calls
  class OmdbApi
    OMDB_URL = 'http://www.omdbapi.com'

    def self.config=(credentials)
      @config = {} unless @config
      @config.update(credentials)
    end

    def self.config
      return @config if @config
      @config = {
        t: ENV['OMDB_KEYWORD']
      }
    end

    def self.movie_info(t)
      movie_response = HTTP.get(
        OMDB_URL,
        params: {
          t: config[:t],
          y: '',
          plot: 'short',
          r: 'json'
        }
      )
      JSON.load(movie_response.to_s)
    end
  end
end
