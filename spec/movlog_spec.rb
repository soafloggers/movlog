require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/movie.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))

describe 'Movie specifications' do
  it 'should get the IMDB ID of a movie' do
    movie = Movlog::Movie.new(keyword: CREDENTIALS[:keyword])

    movie.imdb_id.length.must_be :>, 0
  end
end