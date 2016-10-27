# frozen_string_literal: true
require 'http'

module Airbnb
  # Service for all Airbnb API calls
  class AirbnbApi
    AIRBNB_URL = 'https://api.airbnb.com/v2/search_results'

    def self.config=(credentials)
      @config = {} unless @config
      @config.update(credentials)
    end

    def self.config
      return @config if @config
      @config = {
        client_id: ENV['AIRBNB_CLIENT_ID']
      }
    end

    def self.rooms_result(location)
      airbnb_rooms_response = HTTP.get(
        AIRBNB_URL,
        params: {
          client_id: config[:client_id],
          location: location
        }
      )
      JSON.load(airbnb_rooms_response.to_s)['search_results']
    end
  end
end
