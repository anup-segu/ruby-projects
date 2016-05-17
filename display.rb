require 'colorize'
require_relative 'board'
require_relative 'cursorable'

class Display
  include Cursorable
  attr_reader :board, :game
  attr_accessor :cursor_pos, :message

  def initialize(board, game = nil)
    @board = board
    @game = game
    @cursor_pos = [0, 0]
    @message = "Select a piece, then select a destination."
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :light_white
    end
    { background: bg, color: :black }
  end


  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    puts
    puts message
    puts
    build_grid.each { |row| puts row.join }
  end
end
