require 'http'

module Skyscanner
  class Routes
    attr_reader :apiKey, :request_url
    attr_reader :origin_place, :destination_place, :outbound_partial_date, :inbound_partial_date
    attr_reader :routes, :quotes, :places

    def initialize(apiKey:, market:, currency:, locale:, originPlace:, destinationPlace:, outboundPartialDate:, inboundPartialDate:)
      @apiKey = apiKey
      @origin_place = origin_place
      @destination_place = destination_place
      @outbound_partial_date = outbound_partial_date
      @inbound_partial_date = inbound_partial_date
      @request_url = 'http://partners.api.skyscanner.net/apiservices/browseroutes/v1.0/'+market+'/'+currency+'/'+locale+'/'+originPlace+'/'+destinationPlace+'/'+outboundPartialDate+'/'+inboundPartialDate
      
    end

    def routes
      return @routes if @routes

      skyscanner_routes_response = HTTP.get(
        @request_url,
        params: {
          apiKey: @apiKey
      })
      routes = JSON.load(skyscanner_routes_response.to_s)
      @routes = routes['Routes']
      @quotes = routes['Quotes']
      @places = routes['Places']
    end
  end
end