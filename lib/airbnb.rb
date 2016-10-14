require 'http'

module airbnb

  class roomsinfo
    attr_reader :client_id, :location

    def initialize(client_id, location)
      @client_id = client_id
      @location = location
    end

    def rooms
      return @rooms if @rooms

      airbnb_rooms_response =
        HTTP.get("https://api.airbnb.com/v2/search_results",
                 params: { client_id: @client_id,
                           location: @location
                         })
      rooms = JSON.load(airbnb_rooms_response.to_s)['search_results']
      rooms_data = rooms['listing'].first
      @rooms = { city: rooms_data['city'],
                 id: rooms_data['id']
               }
    end
  end
end
