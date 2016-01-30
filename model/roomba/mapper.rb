require_relative 'map'

class Mapper
  attr_reader :map, :coordinates

  def initialize
    @coordinates = [0, 0]
    @map = Map.new
    @map.set_field(*coordinates, :visited)
  end

  def moved(direction)
    @coordinates = next_coordinates(direction)
    @map.set_field(*coordinates, :visited)
  end

  def blocked(direction)
    coordinates = next_coordinates(direction)
    @map.set_field(*coordinates, :blocked)
  end

  private

  def next_coordinates(direction)
    coordinates = @coordinates.clone
    case direction
      when :right
        coordinates[0] += 1
      when :left
        coordinates[0] -= 1
      when :up
        coordinates[1] += 1
      when :down
        coordinates[1] -= 1
    end
    coordinates
  end
end
