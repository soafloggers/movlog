# frozen_string_literal: true
require 'http'

module Airports
  # Service to transform location to geocode
  class GoogleMapApi
    GOOGLEMAP_URL = 'https://maps.googleapis.com'
    SEARCH_URL = [GOOGLEMAP_URL, 'maps/api/geocode/json'].join('/')

    def self.config=(credentials)
      @config = {} unless @config
      @config.update(credentials)
    end

    def self.config
      return @config if @config
      @config = {
        key: ENV['GOOGLEMAP_KEY']
      }
    end

    def self.geocode(location)
      search_response = HTTP.get(
        SEARCH_URL,
        params: {
          address: location,
          key: config[:key]
        }
      )
      JSON.parse(search_response.to_s)['results'].first
    end
  end
end
