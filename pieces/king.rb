require_relative 'piece'
require_relative 'steppable'

class King < Piece
  include Steppable
  attr_reader :color
  attr_accessor :position

  def initialize(board, position, color)
    super
  end

  def move_dir
    king_dir
  end

  def to_s
    color == :white ? "\u2654 " : "\u265A "
  end

end
