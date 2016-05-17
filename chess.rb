require_relative 'player'

class Chess

  def initialize
    @board = Board.new(true)
    @display = Display.new(@board)
    @player1 = Player.new(@display, "steve", :white)
    @player2 = Player.new(@display, "bob", :black)
    @current_player = @player1
  end

  def run
    until @board.checkmate?(:black) || @board.checkmate?(:white)
      begin
        @current_player.get_turn
      rescue ChessMoveError => e
        @display.message = e.message
        retry
      end

      switch_players
    end
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  chess = Chess.new
  chess.run
end
