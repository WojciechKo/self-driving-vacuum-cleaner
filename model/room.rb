class Room
  attr_reader :width, :length

  def initialize(width, length)
    @width = width
    @length = length
    @tiles = []
    (0...@width).each { |w|
      (0...@length).each { |l|
        value = w == 0 || w == @width - 1 || l == 0 || l == @length - 1 ? :obstacle : :dirt
        @tiles << Tile.new(w, l, value)
      }
    }
  end

  def obstacle(width, length)
    set_tile_value(width, length, :obstacle)
  end

  def gen_obstacle(number)
    sl = (1...@width - 1).to_a.product((1...length - 1).to_a)
    sl.shuffle.first(number).each do |width, length|
      obstacle(width, length)
    end
  end

  def clean(width, length)
    set_tile_value(width, length, :clean)
  end

  def dirt(width, length)
    set_tile_value(width, length, :dirt)
  end

  def roomba(width, length)
    set_tile_value(width, length, :roomba)
  end

  def tile(width, length)
    find_tile(width, length).value
  end

  def each_tile
    @tiles.each { |t| yield(t) }
  end

  private
  def find_tile(width, length)
    @tiles.find { |t| t.width == width && t.length == length }
  end

  def set_tile_value(width, length, state)
    return unless (1...@width - 1).include? width
    return unless (1...@length - 1).include? length

    find_tile(width, length).value = state
  end
end

class Tile
  attr_reader :width, :length
  attr_accessor :value

  def initialize(width, length, value)
    @width = width
    @length = length
    @value = value
  end
end