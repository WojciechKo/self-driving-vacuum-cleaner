class PathFinder
  MOVES = [:left, :right, :up, :down]

  def initialize(mapper)
    @mapper = mapper
  end

  def path_to(field)
    (1..1000).each do |n|
      path = n_steps_paths(n).find { |path| path.destination_field == field }
      return path.moves unless path.nil?
    end
  end

  private
  def n_steps_paths(n)
    if n == 1
      @paths = {}
      @paths[n] ||= MOVES.map { |m| Path.new([m], @mapper) }
                        .select { |p| p.destination_field != :blocked }
    else
      @paths[n] ||= n_steps_paths(n-1)
                        .select { |p| p.destination_field != :blocked }
                        .map(&:moves)
                        .product(MOVES)
                        .map { |p| p[0] + [p[1]] }
                        .map { |moves| Path.new(moves, @mapper) }
                        .select { |p| p.destination_field != :blocked }
    end
  end
end

class Path
  attr_reader :moves

  def initialize(moves, mapper)
    @moves = moves
    @mapper = mapper
  end

  def destination_field
    coordinates = @mapper.coordinates.zip(vector).map { |pair| pair[0] + pair[1] }
    @mapper.map.field(*coordinates)
  end

  def to_s
    moves.to_s
  end

  def vector
    @vector ||= moves.inject([0, 0]) do |vector, move|
      case move
        when :right
          vector[0] += 1
        when :left
          vector[0] -= 1
        when :up
          vector[1] += 1
        when :down
          vector[1] -= 1
      end
      vector
    end
  end
end
