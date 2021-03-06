require_relative 'piece'
require_relative 'steppable'
require 'byebug'

class Knight < Piece
  include Steppable
  attr_reader :color
  attr_accessor :position

  def initialize(board, position, color)
    super
  end

  def move_dir
    knight_dir
  end

  def to_s
    color == :white ? "\u2658 " : "\u265E "
  end

end
