require 'yaml'
require 'http'

credentials = YAML.load(File.read('credentials.yml'))
omdb_response = {}
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

omdb_response[:movie] = movie_response
movie = JSON.load(movie_response.to_s)
results[:movie] = movie

File.write('omdb_response.yml', omdb_response.to_yaml)
File.write('results.yml', results.to_yaml)