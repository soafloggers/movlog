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

    def to_hash
      { meta: @meta.to_hash, flights: @flights.to_hash }
    end
  end

  # Flight info
  class Flight
    attr_reader :carriers, :min_price, :direct, :date
    attr_reader :origin, :destination

    def initialize(data)
      @min_price = data[:min_price]
      @direct = data[:direct]
      @carriers = data[:carriers]
      @origin = data[:origin]
      @destination = data[:destination]
      @date = data[:date]
    end

    def to_hash
      { min_price: @min_price, direct: @direct, carriers: @carriers,
        origin: @origin.to_hash, destination: @destination.to_hash,
        date: @date }
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

    def to_hash
      { name: @name, city_name: @city_name, country_name: @country_name,
        type: @type }
    end
  end
end
