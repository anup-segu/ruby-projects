class NullPiece
  attr_reader :position

  def initialize(board, position)
    @board = board
    @position = position
    @board[position] = self
  end

  def to_s
    "  "
  end
end
