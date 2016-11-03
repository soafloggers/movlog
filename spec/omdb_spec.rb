# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'OMDB specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE_1, record: :new_episodes
    @movie = Movlog::Movie.find(t: OMDB_KEYWORD)
  end

  after do
    VCR.eject_cassette
  end

  it 'should get the data of a movie' do
    @movie.imdb_id.length.must_be :>, 0
    @movie.title.length.must_be :>, 0
    @movie.year.length.must_be :>, 0
    @movie.actors.length.must_be :>, 0
    @movie.poster.length.must_be :>, 0
    @movie.plot.length.must_be :>, 0
    @movie.location.length.must_be :>, 0
  end
end
