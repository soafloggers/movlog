require 'yaml'
require 'http'

credentials = YAML.load(File.read('credentials.yml'))
airbnb_review_response = {}
results = {}

# Airbnb review API
listing_id = '2056659'
role = 'all'
review_response =
  HTTP.get('https://api.airbnb.com/v2/reviews', 
            params: { client_id: credentials[:client_id],
                      listing_id: listing_id,
                      role: role })
airbnb_review_response[:access_token] = review_response
reviews = JSON.load(review_response.to_s)['reviews']

File.write('review_response.yml', airbnb_review_response.to_yaml)
File.write('reviews.yml', reviews.to_yaml)