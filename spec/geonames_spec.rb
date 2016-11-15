# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Geonames specifications' do
  before do
    VCR.insert_cassette CASSETTE_FILE_4, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should get geocoord from Geonames' do
    airport_info = Geonames::AirportInfo.find('Hsinchu')

    airport_info.lat.wont_be_nil
    airport_info.lng.wont_be_nil
  end

  it 'should get airport by geocoord from Geonames' do
    airport_info = Geonames::AirportInfo.find('Hsinchu')
    airports = airport_info.airports

    airports.length.must_be :>, 0
  end
end
