class Sensor
  def initialize(position)
    @position = position
  end

  def check(direction)
    @position.field_at direction
  end
end