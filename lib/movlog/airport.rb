# frozen_string_literal: true

module Geonames
  # airport
  class AirportInfo
    attr_reader :location
    attr_reader :lat, :lng
    attr_reader :airports

    def initialize(data)
      @location = data[:location]
      load_geocoord(data[:geocoord])
    end

    def self.find(location)
      data = {
        location: location,
        geocoord: GeonamesApi.geo_info(location)
      }
      new(data)
    end

    def airports
      return @airports if @airports
      @airports = load_airport(GeonamesApi.near_airports(lat: @lat, lng: @lng))
    end

    private

    def load_geocoord(data)
      @lat = data['lat'].to_f
      @lng = data['lng'].to_f
    end

    def load_airport(airports)
      airports.map do |ap|
        {
          name: ap['name'], countryCode: ap['countryCode'],
          lat: ap['lat'].to_f, lng: ap['lng'].to_f
        }
      end
    end
  end
end
