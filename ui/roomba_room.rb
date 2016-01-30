require 'gosu'
require_relative '../model/roomba/roomba_factory'
require_relative '../model/room'

class RoombaRoom < Gosu::Window
  SCREEN_WIDTH = 60
  SCREEN_HEIGHT = 30
  TILE_SIZE = 20

  CONTROL = {Gosu::Button::KbLeft => :left,
             Gosu::Button::KbRight => :right,
             Gosu::Button::KbUp => :up,
             Gosu::Button::KbDown => :down}

  def initialize
    super SCREEN_WIDTH * TILE_SIZE, SCREEN_HEIGHT * TILE_SIZE, false
    self.caption = 'Hello World!'
    init_room_and_roomba
  end

  def init_room_and_roomba
    @room = Room.new SCREEN_WIDTH, SCREEN_HEIGHT
    @roomba = RoombaFactory.with_fake_components(@room, 10, 10)
  end

  def button_down(id)
    case id
      when Gosu::KbA
        if @auto
          @auto = false
          @auto_thread.kill
        else
          @auto_thread = Thread.new do
            while true
              @roomba.auto_move
              sleep 0.01
            end
          end
          @auto_thread.run
          @auto = true
        end
      when Gosu::KbG
        @room.gen_obstacle(@room.width * @room.length * 0.01)
      when Gosu::KbR
        init_room_and_roomba
      when Gosu::MsLeft
        toggle_obstacle_or_dirt *room_coordinates
      when *CONTROL.keys
        @roomba.move(CONTROL[id])
    end
  end

  def toggle_obstacle_or_dirt(width, length)
    case @room.tile(width, length)
      when :dirt
        @room.obstacle(width, length)
      when :obstacle
        @room.dirt(width, length)
    end
  end

  def draw
    @room.each_tile do |tile|
      image(tile.value).draw(tile.width * TILE_SIZE, height - ((tile.length + 1)* TILE_SIZE), 0)
    end
  end

  def needs_cursor?
    true
  end

  private
  def room_coordinates
    [(mouse_x / TILE_SIZE).to_i, ((height - mouse_y) / TILE_SIZE).to_i]
  end

  def image(tile)
    case tile
      when :clean
        clean
      when :dirt
        dirt
      when :obstacle
        obstacle
      when :roomba
        roomba
    end
  end

  def clean
    @clean_img ||= Gosu::Image.new('img/clean.png')
  end

  def dirt
    @dirt_img ||= Gosu::Image.new('img/dirt.png')
  end

  def obstacle
    @obstacle_img ||= Gosu::Image.new('img/obstacle.png')
  end

  def roomba
    @roomba_img ||= Gosu::Image.new('img/roomba.jpg')
  end
end
