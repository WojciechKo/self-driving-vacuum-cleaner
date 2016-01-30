class Mover
  def initialize(mapper)
    @mapper = mapper
    @planned_moves = []
  end

  def next_move
    moves.shift
  end

  private
  def moves
    if @planned_moves.empty?
      @planned_moves = generate_moves
    end
    @planned_moves
  end

  def generate_moves
    PathFinder.new(@mapper).path_to(:unknown)
  end
end
