require 'yaml'
require 'http'

credentials = YAML.load(File.read('credentials.yml'))
response = {}
results = {}

# Airbnb search reviews API
listing_id = '2056659'
role = 'all'
review_response =
  HTTP.get('https://api.airbnb.com/v2/reviews', 
            params: { client_id: credentials[:client_id],
                      listing_id: listing_id,
                      role: role })
response[:airbnb_review] = review_response
reviews = JSON.load(review_response.to_s)['reviews']
results[:reviews] = reviews

# Find desired movie
keyword = 'star wars'
movie_response = HTTP.get(
  "http://www.omdbapi.com/",
  params: {
    t: keyword,
    y: '',
    plot: 'short',
    r: 'json'
  })

response[:movie] = movie_response
movie = JSON.load(movie_response.to_s)
results[:movie] = movie

File.write('response.yml', response.to_yaml)
File.write('results.yml', results.to_yaml)