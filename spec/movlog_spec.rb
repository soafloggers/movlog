require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/movie.rb'
require './lib/skyscanner.rb'
require './lib/airbnb.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))

describe 'Movie specifications' do
  before do
    @omdb_api = Movlog::OmdbApi.new
  end

  it 'should get the IMDB ID of a movie' do
    movie = Movlog::Movie.new(@omdb_api, t: CREDENTIALS[:keyword])

    movie.imdb_id.length.must_be :>, 0
  end

  it 'should get routes suggested by Skyscanner' do
    routes = Skyscanner::Routes.new(
    	apiKey: CREDENTIALS[:skyscanner_api_key],
    	market: 'GB',
    	currency: 'GBP',
    	locale: 'en-GB',
    	originPlace: 'LON',
    	destinationPlace: 'UK',
    	outboundPartialDate: 'anytime',
    	inboundPartialDate: 'anytime'
    )
    routes.routes.length.must_be :>, 0
  end

  it 'should get the room info of a location' do
    roomsinfo = Airbnb::Roomsinfo.new(airbnb_client_id: CREDENTIALS[:airbnb_client_id], location: "Hsinchu")

    rooms = roomsinfo.rooms
    rooms.length.must_be :>, 0
  end
end
