require 'gosu'

class Window < Gosu::Window
  TILE_SIZE = 20

  CONTROL = {Gosu::Button::KbLeft => :left,
             Gosu::Button::KbRight => :right,
             Gosu::Button::KbUp => :up,
             Gosu::Button::KbDown => :down}

  def initialize(room, roomba)
    super room.width * TILE_SIZE, room.length * TILE_SIZE, false
    self.caption = 'Hello World!'
    @room = room
    @roomba = roomba
  end

  def button_down(id)
    case id
      when Gosu::KbA
        Thread.new do
          while true
            @roomba.auto_move
            sleep 0.05
          end
        end.run
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
      image(tile.value).draw(tile.width * TILE_SIZE, tile.length * TILE_SIZE, 0)
    end
  end

  def needs_cursor?
    true
  end

  private
  def room_coordinates
    [(mouse_x / TILE_SIZE).to_i, (mouse_y / TILE_SIZE).to_i]
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
