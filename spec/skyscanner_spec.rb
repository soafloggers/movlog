# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Skyscanner specifications' do
  before do
    @skyscanner_api = Skyscanner::SkyscannerApi.new(
      api_key: CREDENTIALS[:skyscanner_api_key]
    )
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