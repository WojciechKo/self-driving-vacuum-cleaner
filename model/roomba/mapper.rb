class Mapper

  def initialize
    @coordinates = {width: 0, length: 0}
    @map = Map.new
  end

  def moved(direction)
    @coordinates = next_coordinates(direction)
    @map.set_field(*to_a(@coordinates), :visited)
  end

  def blocked(direction)
    coordinates = next_coordinates(direction)
    @map.set_field(*to_a(coordinates), :blocked)
  end

  private

  def to_a(coordinates)
    [coordinates[:width], coordinates[:length]]
  end

  def next_coordinates(direction)
    coordinates = @coordinates.clone
    case direction
      when :right
        coordinates[:width] += 1
      when :left
        coordinates[:width] -= 1
      when :up
        coordinates[:length] += 1
      when :down
        coordinates[:length] -=1
    end
    coordinates
  end
end
