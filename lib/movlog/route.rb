# frozen_string_literal: true

module Skyscanner
  # Route info
  class Route
    attr_reader :meta
    attr_reader :flights

    def initialize(data)
      @meta = RouteMeta.new(data[:meta])
      @flights = data[:flights]
    end

    def self.find(meta)
      route_info = RouteInfo.find(meta)
      data = {
        meta: meta,
        flights: route_info.parse_flights
      }
      new(data)
    end
  end
  # Flight info
  class Flight
    attr_reader :min_price
    attr_reader :direct
    attr_reader :carriers
    attr_reader :origin, :destination
    attr_reader :date

    def initialize(data)
      @min_price = data[:min_price]
      @direct = data[:direct]
      @carriers = data[:carriers]
      @origin = data[:origin]
      @destination = data[:destination]
      @date = data[:date]
    end
  end
  # Place info
  class Place
    attr_reader :name, :city_name, :country_name
    attr_reader :type

    def initialize(data)
      @name = data['Name']
      @city_name = data['CityName']
      @country_name = data['CountryName']
      @type = data['Type']
    end

    def self.find(data)
      new(data)
    end
  end
end
