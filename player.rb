require_relative "display"

class Player
  def initialize(board)
    @display = Display.new(board)
    @selected_piece = false
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    @selected_piece = true if @display.board[result] == piece
    result
  end

  def play_turn
    while true
      move
    end
  end
end

board = Board.new
steve = Player.new(board)
steve.play_turn
