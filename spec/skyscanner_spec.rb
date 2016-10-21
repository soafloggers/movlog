# frozen_string_literal: true
require_relative 'spec_helper.rb'
require_relative '../lib/skyscanner_api'
require_relative '../lib/routes.rb'

describe 'Skyscanner specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
    c.filter_sensitive_data('<SKYSCANNER_API_KEY>') { CREDENTIALS[:skyscanner_api_key] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE_2, record: :new_episodes
    @skyscanner_api = Skyscanner::SkyscannerApi.new(
      api_key: CREDENTIALS[:skyscanner_api_key]
    )
  end

  after do
    VCR.eject_cassette
  end

  it 'should get routes suggested by Skyscanner' do
    route_meta = Skyscanner::RouteMeta.new(
      market: 'GB', currency: 'GBP', locale: 'en-GB',
      origin_place: 'LON', destination_place: 'UK',
      outbound_partial_date: 'anytime', inbound_partial_date: 'anytime'
    )
    routes = Skyscanner::Route.new(
      skyscanner_api: @skyscanner_api,
      route_meta: route_meta
    )
    routes = routes.routes_info
    routes.length.must_be :>, 0
  end
end
