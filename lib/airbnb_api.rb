require 'http'

module Airbnb
  class AirbnbApi
    AIRBNB_URL = 'https://api.airbnb.com/v2/search_results'

    def initialize(client_id:nil)
    	@client_id = client_id
    end

    def rooms_result(location)
      airbnb_rooms_response = HTTP.get(
      	AIRBNB_URL,
        params: { 
          client_id: @client_id,
          location: location
      })
      rooms = JSON.load(airbnb_rooms_response.to_s)['search_results']
    end
  end
end
