# frozen_string_literal: true
require_relative 'airbnb_api'

module Airbnb
  # Room info
  class RoomsInfo
    attr_reader :location
    attr_reader :rooms

    def initialize(airbnb_api: nil, location: nil)
      @airbnb_api = airbnb_api
      @location = location
    end

    def rooms
      return @rooms if @rooms

      rooms_data = @airbnb_api.rooms_result(@location)
      @rooms = rooms_data.map do |item|
        room(item)
      end
    end

    private

    def room(item)
      item = item
      {
        city: item['listing']['city'],
        name: item['listing']['name'],
        pic_url: item['listing']['picture_url'],
        id: item['listing']['id'],
        person_capacity: item['listing']['person_capacity'],
        primary_host: item['listing']['primary_host'],
        star_rating: item['listing']['star_rating'],
        listing_currency: item['pricing_quote']['listing_currency'],
        nightly_price: item['pricing_quote']['nightly_price']
      }
    end
  end
end
