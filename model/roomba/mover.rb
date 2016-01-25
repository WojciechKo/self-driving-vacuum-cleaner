class Mover
  def initialize(position)
    @position = position
  end

  def move(direction)
    @position.clean
    @position.move direction
  end
end
