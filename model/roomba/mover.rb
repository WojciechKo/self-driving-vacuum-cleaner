class Mover
  def initialize(mapper)
    @path_finder = PathFinder.new mapper
    @planned_moves = []
    @mapper = mapper
  end

  def next_move
    moves.pop
  end

  private
  def moves
    if @planned_moves.empty?
      @planned_moves = generate_moves
    end
    @planned_moves
  end

  def generate_moves
    @path_finder.path_to(:dirt).map(&:to_s)
  end
end

class PathFinder
  def initialize(mapper)
    @mapper = mapper
  end

  def path_to(field)

  end
end
