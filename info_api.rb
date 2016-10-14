require 'yaml'
require 'http'

credentials = YAML.load(File.read('credentials.yml'))
response = {}
results = {}

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

# Get filming locations from IMDB website

# Airbnb search reviews API
airbnb_response =
  HTTP.get('https://api.airbnb.com/v2/reviews',
            params: { client_id: credentials[:airbnb_client_id],
                      listing_id: credentials[:airbnb_listing_id],
                      role: 'all' })
response[:airbnb] = airbnb_response
reviews = JSON.load(airbnb_response.to_s)['reviews']
results[:reviews] = reviews

# Airbnb search rooms API
airbnb_rooms_response =
  HTTP.get('https://api.airbnb.com/v2/search_results',
            params: { client_id: '3092nxybyb0otqw18e8nh5nty',
                      #locale: credentials[:airbnb_locale],
                    })
response[:airbnb_rooms] = airbnb_rooms_response
rooms = JSON.load(airbnb_rooms_response.to_s)['rooms']
results[:rooms] = rooms

File.write('response.yml', response.to_yaml)
File.write('results.yml', results.to_yaml)
