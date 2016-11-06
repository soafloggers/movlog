# frozen_string_literal: true
require_relative 'skyscanner_api'

module Skyscanner
  # Route info
  class RouteInfo
    attr_reader :routes, :quotes, :places, :carriers

    def initialize(data)
      load_data(data)
    end

    def self.find(meta)
      data = SkyscannerApi.routes_info(meta)
      new(data)
    end

    def parse_flights
      @quotes.map do |quo|
        data = {
          min_price: quo['MinPrice'], direct: quo['Direct'],
          carriers: get_carriers(quo['OutboundLeg']['CarrierIds']),
          origin: get_place(quo['OutboundLeg']['OriginId']),
          destination: get_place(quo['OutboundLeg']['DestinationId']),
          date: quo['OutboundLeg']['DepartureDate']
        }
        Flight.new(data)
      end
    end

    private

    def load_data(data)
      @routes = data['Routes']
      load_quotes(data['Quotes'])
      load_places(data['Places'])
      load_carriers(data['Carriers'])
    end

    def load_quotes(quotes)
      @quotes = quotes.select do |quo|
        quo['OutboundLeg']['CarrierIds'].length.nonzero?
      end
    end

    def load_places(places)
      @places = {}
      places.each { |place| @places[place['PlaceId']] = Place.new(place) }
    end

    def load_carriers(carriers)
      @carriers = {}
      carriers.each do |carrier|
        @carriers[carrier['CarrierId']] = carrier['Name']
      end
    end

    def get_place(place_id)
      @places[place_id]
    end

    def get_carriers(carrier_ids)
      carrier_ids.map { |cid| @carriers[cid] }
    end
  end
  # Query parameters
  class RouteMeta
    attr_reader :market, :currency, :locale
    attr_reader :origin, :destination
    attr_reader :outbound, :inbound

    def initialize(data)
      load_env_data(data['market'], data['currency'], data['locale'])
      load_place(data['origin'], data['destination'])
      load_date(data['outbound'], data['inbound'])
    end

    private

    def load_env_data(market, currency, locale)
      @market = market
      @currency = currency
      @locale = locale
    end

    def load_place(origin, destination)
      @origin = origin
      @destination = destination
    end

    def load_date(outbound, inbound)
      @outbound = outbound
      @inbound = inbound
    end
  end
end
