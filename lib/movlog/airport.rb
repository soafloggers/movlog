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
      @airports = GeonamesApi.near_airports(lat: @lat, lng: @lng)
    end

    private

    def load_geocoord(data)
      @lat = data['lat']
      @lng = data['lng']
    end
  end
end
