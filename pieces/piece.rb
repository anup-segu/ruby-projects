class Piece
  attr_accessor :board
  
  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    @board[position] = self
  end

  def move(new_pos)
    @board[self.position] = NullPiece.new(self.position)
    @board[new_pos] = self
  end



end
