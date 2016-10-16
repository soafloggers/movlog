require_relative 'airbnb_api'

module Airbnb
  class RoomsInfo
    attr_reader :location
    attr_reader :rooms

    def initialize(airbnb_api:nil, location:nil)
      @airbnb_api = airbnb_api
      @location = location
    end

    def rooms
      return @rooms if @rooms

      rooms_data = @airbnb_api.rooms_result(@location)
      @rooms = rooms_data.map { |item|
        room = room(item)
      }
    end

    private

    def room(item)
      item = item['listing']
      room = {
        city: item['city'],
        name: item['name'],
        pic_url: item['picture_url'],
        id: item['id']
      }
    end
  end
end
