require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable
  attr_reader :color
  attr_accessor :position

  def initialize(board, position, color)
    super
  end

  def move_dir
    orthagonal_dir
  end

  def to_s
    color == :white ? "\u2656 " : "\u265C "
  end

end
