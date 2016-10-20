# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Airbnb specifications' do
  before do
    @airbnb_api = Airbnb::AirbnbApi.new(
      client_id: CREDENTIALS[:airbnb_client_id]
    )
  end

  it 'should get the room info of a location' do
    rooms_info = Airbnb::RoomsInfo.new(
      airbnb_api: @airbnb_api,
      location: 'Hsinchu'
    )
    rooms = rooms_info.rooms
    rooms.length.must_be :>, 0
  end
end