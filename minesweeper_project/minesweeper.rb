require_relative 'board'
require_relative 'tile'
require 'byebug'
require 'colorize'

class MineSweeper
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def solved?
    board.solved?
  end

  def over?
    board.over?
  end

  def play_turn
    system("clear")
    board.render
    pos = get_pos
    action = get_action
    if action == "r"
      board[pos].reveal(board)
    end
    board[pos].flag if action == "f"
  end

  def run
    board.seed_bombs(board.bomb_count)
    play_turn until solved? || over?
    board.reveal_all if over?
    board.render
    puts "Nice bruh".cyan if solved? && !over?
    puts "BOOM! YOU'RE DEAD!".red if over?
  end

  def get_pos
    pos = nil
    puts "Please enter a position on the board (e.g., '3,4')"
    print "> "
    pos = gets.chomp.split(",").map(&:to_i).reverse
    until pos.length == 2 && valid_pos?(pos)
      puts "Invalid position entered (did you use a comma?)"
      print "> "
      pos = gets.chomp.split(",").map(&:to_i).reverse
    end
    pos
  end

  def valid_pos?(pos)
    (pos[0]>=0 && pos[0] < board.grid[0].length) &&
      (pos[1]>= 0 && pos[1] < (board.grid.length))
  end

  def get_action
    action = nil
    until action && valid_action?(action)
      puts "Would you like to reveal (r) or flag (f)?"
      print "> "
      action = gets.chomp
    end
    action
  end

  def valid_action?(action)
    action == "f" || action == "r"
  end
end

game = MineSweeper.new(Board.new).run
