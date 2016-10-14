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

File.write('response.yml', response.to_yaml)
File.write('results.yml', results.to_yaml)