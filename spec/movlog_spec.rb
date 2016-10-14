require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/movie.rb'
require './lib/skyscanner.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))

describe 'Movie specifications' do
  it 'should get the IMDB ID of a movie' do
    movie = Movlog::Movie.new(keyword: CREDENTIALS[:keyword])

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
end