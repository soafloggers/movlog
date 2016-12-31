# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Skyscanner specifications' do
  before do
    VCR.insert_cassette CASSETTE_FILE_2, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should get routes suggested by Skyscanner' do
    route_meta = {
      market: 'TW', currency: 'TWD', locale: 'zh-TW',
      origin: '48.85341,2.3488-Latlong',
      destination: '-43.58832,171.53011-Latlong',
      outbound: 'anytime', inbound: 'anytime'
    }
    route = Skyscanner::Route.find(route_meta)
    flights = route.flights

    flights.length.must_be :>, 0
  end
end
