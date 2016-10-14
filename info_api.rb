require 'yaml'
require 'http'

credentials = YAML.load(File.read('credentials.yml'))
response = {}
results = {}

# Get filming locations from IMDB website
# Find desired movie
movie_response = HTTP.get(
  "http://www.omdbapi.com/",
  params: {
    t: credentials[:keyword],
    y: '',
    plot: 'short',
    r: 'json'
  })

response[:movie] = movie_response
movie = JSON.load(movie_response.to_s)['imdbID']
results[:movie] = movie

# Airbnb search rooms API
location = 'Hsinchu'
airbnb_rooms_response = HTTP.get(
  'https://api.airbnb.com/v2/search_results',
    params: { 
      client_id: credentials[:airbnb_client_id],
      location: location
    })
response[:airbnb_rooms] = airbnb_rooms_response
rooms = JSON.load(airbnb_rooms_response.to_s)['search_results']
results[:rooms] = rooms

#Skyscanner API
market = 'GB'
currency = 'GBP'
locale = 'en-GB'
originPlace = 'LON'
destinationPlace = 'UK'
outboundPartialDate = 'anytime'
inboundPartialDate = 'anytime'
skyscanner_response = HTTP.get(
  'http://partners.api.skyscanner.net/apiservices/browseroutes/v1.0/'+market+'/'+currency+'/'+locale+'/'+originPlace+'/'+destinationPlace+'/'+outboundPartialDate+'/'+inboundPartialDate,
  params: {
    apiKey: credentials[:skyscanner_api_key]
  })
response[:skyscanner] = skyscanner_response
routes = JSON.load(skyscanner_response.to_s)
results[:routes] = routes

File.write('response.yml', response.to_yaml)
File.write('results.yml', results.to_yaml)
