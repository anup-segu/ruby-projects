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
      moves << [1, -1] if @board[[self.position[0] + 1, self.position[1] - 1]].color == :white
      moves << [1, 1] if @board[[self.position[0] + 1, self.position[1] + 1]].color == :white
    when :white
      moves << [-1, -1] if @board[[self.position[0] - 1, self.position[1] - 1]].color == :black
      moves << [-1, 1] if @board[[self.position[0] - 1, self.position[1] + 1]].color == :black
    end

    moves
  end

  def to_s
    color == :white ? "\u2659 " : "\u265F "
  end

end
