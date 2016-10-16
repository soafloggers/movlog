require_relative 'spec_helper.rb'

describe 'Movlog specifications' do
  before do
    # @omdb_api = Movlog::OmdbApi.new()

    @airbnb_api = Airbnb::AirbnbApi.new(
      client_id: CREDENTIALS[:airbnb_client_id]
    )

    @skyscanner_api = Skyscanner::SkyscannerApi.new(
      api_key: CREDENTIALS[:skyscanner_api_key]
    )
  end

  # it 'should get the IMDB ID of a movie' do
  #   movie = Movlog::Movie.new(@omdb_api, t: CREDENTIALS[:keyword])

  #   movie.imdb_id.length.must_be :>, 0
  # end

  it 'should get routes suggested by Skyscanner' do
    route_meta = Skyscanner::RouteMeta.new(
      market: 'GB', currency: 'GBP', locale: 'en-GB', 
      origin_place: 'LON', destination_place: 'UK', 
      outbound_partial_date: 'anytime', inbound_partial_date: 'anytime'
    )
    routes = Skyscanner::Route.new(
      skyscanner_api: @skyscanner_api,
      route_meta: route_meta
    )
    routes = routes.routes_info
    routes.length.must_be :>, 0
  end

  it 'should get the room info of a location' do
    rooms_info = Airbnb::RoomsInfo.new(
      airbnb_api: @airbnb_api, 
      location: "Hsinchu"
    )
    rooms = rooms_info.rooms
    rooms.length.must_be :>, 0
  end
end
