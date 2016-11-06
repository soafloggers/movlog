# frozen_string_literal: true
require 'http'

module Skyscanner
  # Service for all SkyScanner API calls
  class SkyscannerApi
    SKY_URL = 'http://partners.api.skyscanner.net/apiservices/browseroutes/'
    API_VER = 'v1.0'
    SKY_API_URL = URI.join(SKY_URL, "#{API_VER}/")

    def self.config=(credentials)
      @config = {} unless @config
      @config.update(credentials)
    end

    def self.config
      return @config if @config
      @config = {
        api_key: ENV['SKY_API_KEY']
      }
    end

    def self.routes_info(data)
      skyscanner_routes_response = HTTP.get(
        route_info_url(data),
        params: {
          apiKey: config[:api_key]
        }
      )
      JSON.load(skyscanner_routes_response.to_s)
    end

    private

    def self.route_info_url(data)
      URI.join(
        SKY_API_URL,
        route_env_param(data[:market], data[:currency], data[:locale]),
        route_place_param(data[:origin], data[:destination]),
        route_date_param(data[:outbound], data[:inbound])
      )
    end

    def self.route_env_param(market, currency, locale)
      "#{market}/#{currency}/#{locale}/"
    end

    def self.route_place_param(origin, destination)
      "#{origin}/#{destination}/"
    end

    def self.route_date_param(outbound, inbound)
      "#{outbound}/#{inbound}"
    end
  end
end
