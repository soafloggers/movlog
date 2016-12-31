# frozen_string_literal: true

module Airports
  # airport
  class AirportInfo
    attr_reader :location
    attr_reader :lat, :lng
    attr_reader :airports

    def initialize(data)
      @location = data[:location]
      load_geocode(data[:geocode])
    end

    def self.find(location)
      data = {
        location: location,
        geocode: GoogleMapApi.geocode(location)
      }
      new(data)
    end

    def airports
      return @airports if @airports
      @airports = load_airport(GeonamesApi.near_airports(lat: @lat, lng: @lng))
    end

    private

    def load_geocode(data)
      data = data['geometry']['location']
      @lat = data['lat'].to_f
      @lng = data['lng'].to_f
    end

    def load_airport(airports)
      airports.map do |ap|
        if ap['name'].include? 'Air'
          {
            name: ap['name'], country_code: ap['countryCode'],
            lat: ap['lat'].to_f, lng: ap['lng'].to_f
          }
        end
      end.compact
    end
  end
end
