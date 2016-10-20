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
      item = item['listing']
      {
        city: item['city'],
        name: item['name'],
        pic_url: item['picture_url'],
        id: item['id']
      }
    end
  end
end
