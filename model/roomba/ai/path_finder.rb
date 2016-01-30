class PathFinder
  MOVES = [:left, :right, :up, :down]

  def initialize(mapper)
    @mapper = mapper
  end

  def path_to(field)
    (1..1000).each do |n|
      path = n_steps_paths(n).find { |vector, path| path.destination_field == field }
      return path[1].moves unless path.nil?
    end
  end

  private
  def n_steps_paths(n)
    if n == 1
      @paths = {[0, 0] => Path.new([], @mapper)}
      @paths.merge!(MOVES.map { |m| Path.new([m], @mapper) }
                        .select { |p| p.destination_field != :blocked }
                        .inject({}) { |result, path| result[path.vector] = path; result })
    else
      @paths = @paths
                   .select { |vector, path| path.moves.size == (n -1) }
                   .values
                   .map(&:moves)
                   .product(MOVES)
                   .map { |p| Path.new(p[0] + [p[1]], @mapper) }
                   .select { |p| p.destination_field != :blocked }
                   .inject({}) { |result, path| result[path.vector] = path; result }
                   .merge(@paths)

      @paths.select { |vector, path| path.moves.size == n }
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
