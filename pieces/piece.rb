class Piece
  attr_accessor :board, :position
  attr_reader :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    @board[position] = self
  end

end
