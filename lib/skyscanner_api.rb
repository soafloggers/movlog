# frozen_string_literal: true
require 'http'

module Skyscanner
  # Service for all FB API calls
  class SkyscannerApi
    SKY_URL = 'http://partners.api.skyscanner.net/apiservices/browseroutes/'
    API_VER = 'v1.0'
    SKY_API_URL = URI.join(SKY_URL, "#{API_VER}/")

    def initialize(api_key:nil)
      @api_key = api_key
    end

    def routes_info(route_meta)
      skyscanner_routes_response = HTTP.get(
        routes_info_url(route_meta),
        params: {
          apiKey: @api_key
      })
      JSON.load(skyscanner_routes_response.to_s)
    end

    private 

    def routes_info_url(route_meta)
      URI.join(SKY_API_URL, 
        "#{route_meta.market}/#{route_meta.currency}/#{route_meta.locale}/",
        "#{route_meta.origin_place}/#{route_meta.destination_place}/",
        "#{route_meta.outbound_partial_date}/#{route_meta.inbound_partial_date}"
      )
    end
  end
end