require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/airbnb.rb'

CREDENTIALS = YAML.load(File.read('./config/credentials.yml'))

describe 'airbnb specifications' do
  it 'should get the room info of a location' do
    roomsinfo = Airbnb::Roomsinfo.new(airbnb_client_id: CREDENTIALS[:airbnb_client_id], location: "Hsinchu")

    rooms = roomsinfo.rooms
    rooms.length.must_be :>, 0
  end
end
