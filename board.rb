class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, "  ") }
    populate
  end

  def populate

  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0,@grid.length-1) &&
      y.between?(0,@grid[0].length-1)
  end

  def move(start_pos, end_pos)
    starting_piece = self[start_pos]
    raise ArgumentError.new("Starting position is empty") if starting_piece.nil?
    ending_piece = self[end_pos]
    raise ArgumentError.new("Starting position is empty") if !ending_piece.nil? && ending_piece.color == starting_piece.color

    self[end_pos] = starting_piece
    self[start_pos] = nil
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, target)
    x,y = pos
    @grid[x][y] = target
  end

  def has_piece?(pos)
    !(self[pos].is_a?(NullPiece))
  end

end
