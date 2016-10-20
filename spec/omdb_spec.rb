# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'OMDB specifications' do
  before do
    @omdb_api = Movlog::OmdbApi.new
  end

  it 'should get the IMDB ID of a movie' do
    movie = Movlog::Movie.new(@omdb_api, t: CREDENTIALS[:keyword])
    movie.imdb_id.length.must_be :>, 0
  end
end