require_relative 'model/position'
require_relative 'model/room'

require_relative 'model/roomba/cleaner'
require_relative 'model/roomba/engine'
require_relative 'model/roomba/sensor'
require_relative 'model/roomba/roomba'

require_relative 'ui/window.rb'

# Dir["model/*.rb"].each {|file| require_relative file }
# Dir["model/roomba/*.rb"].each {|file| require_relative file }

room = Room.new 60, 30
position = Position.new room, 10, 10

def create_roomba(position)
  sensor = Sensor.new position
  engine = Engine.new position
  cleaner = Cleaner.new position

  Roomba.new sensor, engine, cleaner
end

roomba = create_roomba(position)

window = Window.new room, roomba
window.show
