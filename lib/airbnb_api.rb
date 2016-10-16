require 'http'

module Airbnb

  class AirbnbAPI
    Airbnb_URL = 'https://api.airbnb.com/v2/search_results'

    #attr_reader :airbnb_client_id, :location

    #def initialize(airbnb_client_id:)
    #  @airbnb_client_id = airbnb_client_id
      #@location = location
    #end
    def initialize()
    end

    def airbnb_rooms_info(cid,loc)
      airbnb_rooms_response =
        HTTP.get(Airbnb_URL,
                 params: { client_id: cid,
                           location: loc
                         })
      JSON.load(airbnb_rooms_response.to_s)['search_results']
      #rooms_data = rooms.first['listing']
    #  @rooms = {city: rooms_data['city'],
        #        id: rooms_data['id']
          #     }
    end

  end

end
