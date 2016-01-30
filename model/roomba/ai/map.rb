class Map
  def initialize
    @map = Hash.new(Hash.new(:unknown))
  end

  def set_field(width, length, field)
    @map[width] = @map[width].merge({length => field})
  end

  def field(width, length)
    @map[width][length]
  end
end
