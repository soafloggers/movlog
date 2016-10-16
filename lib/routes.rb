require_relative 'skyscanner_api'

module Skyscanner
  class Route
    attr_reader :route_meta
    attr_reader :routes

    def initialize(skyscanner_api:nil, route_meta:nil)
      @skyscanner_api = skyscanner_api
      @route_meta = route_meta
    end

    def routes_info
      return @routes if @routes

      @routes = @skyscanner_api.routes_info(@route_meta)
      routes
    end
  end

  class RouteMeta
    attr_reader :market, :currency, :locale
    attr_reader :origin_place, :destination_place
    attr_reader :outbound_partial_date, :inbound_partial_date

    def initialize(market:nil, currency:nil, locale:nil,
                   origin_place:nil, destination_place:nil,
                   outbound_partial_date:nil, inbound_partial_date:nil)
      @market = market
      @currency = currency
      @locale = locale
      @origin_place = origin_place
      @destination_place = destination_place
      @outbound_partial_date = outbound_partial_date
      @inbound_partial_date = inbound_partial_date
    end
  end
end
