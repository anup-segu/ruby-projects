require_relative 'piece'
require_relative 'steppable'

class Pawn < Piece
  include Steppable
  attr_reader :color
  attr_accessor :position

  def initialize(board, position, color)
    super
  end

  def move_dir
    moves = []
    if self.position[0] == 1 || self.position[0] == 6
      moves += [[1,0],[2,0]] if color == :black
      moves += [[-1,0],[-2,0]] if color == :white
    else
      moves << [1,0] if color == :black
      moves << [-1,0] if color == :white
    end

    case self.color
    when :black
      left = [self.position[0] + 1, self.position[1] - 1]
      right = [self.position[0] + 1, self.position[1] + 1]
      if @board.in_bounds?(left)
        moves << [1, -1] if @board[left].color == :white
      end

      if @board.in_bounds?(right)
        moves << [1, 1] if @board[right].color == :white
      end

    when :white
      left = [self.position[0] - 1, self.position[1] - 1]
      right = [self.position[0] - 1, self.position[1] + 1]
      if @board.in_bounds?(left)
          moves << [-1, -1] if @board[left].color == :black
      end

      if @board.in_bounds?(right)
        moves << [-1, 1] if @board[right].color == :black
      end
    end

    moves
  end

  def to_s
    color == :white ? "\u2659 " : "\u265F "
  end

end
