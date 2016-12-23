# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'OMDB specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE_1, record: :new_episodes
    @movies = Movlog::Movies.find(s: OMDB_KEYWORD)
  end

  after do
    VCR.eject_cassette
  end

  it 'should get the data of a movie' do
    @movies.movies.length.must_be :>, 0
    @movies.num.to_i.must_be :>, 0
  end

  it 'should get the filming location of a movie' do
    @movies.movies.first.get_location.length.must_be :>, 0
  end
end
