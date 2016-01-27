class Position
  def initialize(room, width = 0, length = 0)
    @room = room
    @current_width = width
    @current_length = length
    @room.roomba *current_coordinates
  end

  def current_field
    @room.tile *current_coordinates
  end

  def field_at(direction)
    @room.tile *coordinates_after_move(direction)
  end

  def clean
    @room.clean *current_coordinates
  end

  def move(direction)
    @current_width, @current_length = coordinates_after_move(direction)
    @room.roomba *current_coordinates
  end

  private
  def current_coordinates
    [@current_width, @current_length]
  end

  def coordinates_after_move(direction)
    case direction
      when :left then
        [@current_width - 1, @current_length]
      when :right then
        [@current_width + 1, @current_length]
      when :up then
        [@current_width, @current_length + 1]
      when :down then
        [@current_width, @current_length - 1]
      else
        raise "unknown direction: #{direction}"
    end
  end
end