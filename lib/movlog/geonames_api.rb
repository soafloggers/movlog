# frozen_string_literal: true
require 'http'

module Airports
  # Service for transformation of location and find near airport
  class GeonamesApi
    GEONAMES_URL = 'http://api.geonames.org'
    SEARCH_URL = [GEONAMES_URL, 'searchJSON'].join('/')
    FIND_NEARBY_URL = [GEONAMES_URL, 'findNearbyJSON'].join('/')

    def self.config=(credentials)
      @config = {} unless @config
      @config.update(credentials)
    end

    def self.config
      return @config if @config
      @config = {
        username: ENV['GEONAMES_USERNAME']
      }
    end

    def self.geo_info(location)
      search_response = HTTP.get(
        SEARCH_URL,
        params: {
          username: config[:username],
          q: location,
          fuzzy: 0.5,
          maxRows: 1
        }
      )
      JSON.parse(search_response.to_s)['geonames'].first
    end

    def self.near_airports(lat:, lng:)
      findnearby_response = HTTP.get(
        FIND_NEARBY_URL,
        params: {
          username: config[:username],
          fcode: 'AIRP',
          lat: lat, lng: lng,
          radius: 200, maxRows: 50
        }
      )
      JSON.parse(findnearby_response.to_s)['geonames']
    end
  end
end
