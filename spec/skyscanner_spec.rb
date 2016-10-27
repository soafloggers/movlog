# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Skyscanner specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
    c.filter_sensitive_data('<SKY_API_KEY>') { ENV['SKY_API_KEY'] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE_2, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should get routes suggested by Skyscanner' do
    route_meta = {
      market: 'GB', currency: 'GBP', locale: 'en-GB',
      origin: 'LON', destination: 'UK',
      outbound: 'anytime', inbound: 'anytime'
    }
    routes = Skyscanner::Route.find(route_meta)
    routes = routes.routes_info
    routes.length.must_be :>, 0
  end
end
