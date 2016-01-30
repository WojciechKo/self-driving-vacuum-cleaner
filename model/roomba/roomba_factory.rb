require_relative '../position'

require_relative 'cleaner'
require_relative 'engine'
require_relative 'sensor'
require_relative 'roomba'

class RoombaFactory
  def self.with_fake_components(room, width, length)
    position = Position.new room, width, length

    sensor = Sensor.new position
    engine = Engine.new position
    cleaner = Cleaner.new position

    Roomba.new sensor, engine, cleaner
  end
end