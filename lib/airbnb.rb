require_relative 'airbnb_api'

module Airbnb

  class Roomsinfo
    attr_reader :location, :airbnb_client_id

    def initialize(airbnb_api)
      @airbnb_api = airbnb_api
      #rooms = @airbnb_api.airbnb_rooms_info(cid,loc)
      @airbnb_client_id = airbnb_client_id
      @location = location
    end

    def rooms
      return @rooms if @rooms

      #airbnb_rooms_response =
    #    HTTP.get("https://api.airbnb.com/v2/search_results",
      #           params: { client_id: @airbnb_client_id,
      #                     location: @location
      #                   })
      #rooms = JSON.load(airbnb_rooms_response.to_s)['search_results']
      rooms = @airbnb_api.airbnb_rooms_info(@airbnb_client_id,@location)
      rooms_data = rooms.first['listing']
      @rooms = {city: rooms_data['city'],
                id: rooms_data['id']
               }
    end
  end
end
