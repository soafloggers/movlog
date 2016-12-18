# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'Airbnb specifications' do
  before do
    VCR.insert_cassette CASSETTE_FILE_3, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should get the room info of a location' do
    rooms_info = Airbnb::RoomsInfo.find('Ostuni')
    rooms = rooms_info.rooms
    rooms.length.must_be :>, 0
  end
end
