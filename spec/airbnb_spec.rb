# frozen_string_literal: true
require_relative 'spec_helper.rb'
require_relative '../lib/airbnb_api'
require_relative '../lib/room.rb'


describe 'Airbnb specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
    c.filter_sensitive_data('<airbnb_client_id>') { CREDENTIALS[:airbnb_client_id] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE_3, record: :new_episodes
    @airbnb_api = Airbnb::AirbnbApi.new(
      client_id: CREDENTIALS[:airbnb_client_id]
    )

  end

  after do
    VCR.eject_cassette
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
