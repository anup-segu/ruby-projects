require_relative "display"
require_relative "./pieces/errors"
require 'byebug'

class Player
  attr_reader :name, :color

  def initialize(display, name, color)
    @display = display
    @name = name
    @selected_piece = false
    @selected_space = false
    @color = color
  end

  def select_own_piece
    result = nil

    until result
      @display.render
      result = @display.get_input
    end

    if @display.board.has_piece?(result) \
      && @display.board[result].color == @color

      @selected_piece = true
    end

    result
  end

  def select_destination
    result = nil

    until result
      @display.render
      result = @display.get_input
    end

    if !@display.board.has_piece?(result) \
      || @display.board[result].color != @color

      @selected_space = true
    end

    result
  end

  def get_turn
    @selected_piece = false
    until @selected_piece
      first_position = select_own_piece
    end

    @display.message = "#{@display.board[first_position].to_s} is selected.\nSelect a destination."

    @selected_space = false
    until @selected_space
      second_position = select_destination
    end

    raise ChessMoveError.new "Invalid move, try again" unless @display.board[first_position].moves_on_board.include?(second_position)

    @display.message = "Select a piece, then select a destination."
    @display.board.move(first_position, second_position)
  end

end

# board = Board.new(true)
# steve = Player.new(board)
# steve.play_turn
