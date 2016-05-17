class Piece
  attr_accessor :board, :position
  attr_reader :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    @board[position] = self
  end

  def valid_moves
    moves_on_board.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(move)
    new_board = @board.dup
    new_board.move!(@position, move)
    new_board.in_check?(@color)
  end
end
