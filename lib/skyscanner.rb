require 'http'

module Skyscanner
  class Routes
    attr_reader :origin_place, :destination_place, :outbound_partial_date, :inbound_partial_date
    attr_reader :routes, :quotes, :places

    def initialize(apiKey, market, currency, locale, originPlace, destinationPlace, outboundPartialDate='anytime', inboundPartialDate='anytime')
      @origin_place = origin_place
      @destination_place = destination_place
      @outbound_partial_date = outbound_partial_date
      @inbound_partial_date = inbound_partial_date

    end

    def routes
      return @routes if @routes

      skyscanner_routes_response = HTTP.get(
        'http://partners.api.skyscanner.net/apiservices/browseroutes/v1.0/'+market+'/'+currency+'/'+locale+'/'+originPlace+'/'+destinationPlace+'/'+outboundPartialDate+'/'+inboundPartialDate,
        params: {
          apiKey: credentials[:skyscanner_api_key]
        })
      routes = JSON.load(skyscanner_routes_response.to_s)
      @routes = routes['Routes']
      @quotes = routes['Quotes']
      @places = routes['Places']
    end
  end
end