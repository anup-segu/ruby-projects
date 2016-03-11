require './board'
require 'byebug'

class Tile
  attr_accessor :flagged, :bombed, :revealed, :bombs_nearby
  attr_reader :pos
  def initialize(x, y, bombed = false)
    @bombed = bombed
    @flagged = false
    @revealed = false
    @pos = [x, y]
    @bombs_nearby = 0
  end

  def reveal(board)
    self.neighbor_bomb_count(board)
    return self.revealed = true if self.bombs_nearby > 0
    self.revealed = true
    self.neighbors(board).each { |tile| tile.reveal(board) if tile.revealed == false }
  end

  def flag
    self.flagged = true
  end

  def to_s
    #other methods will implicitly convert Tile to strings
    #will output to the following strings for display purposes
    case
    when @bombed && @revealed
      "B"
    when @flagged && !(@revealed)
      "F"
    when @revealed
      self.bombs_nearby.to_s
    else
      " "
    end
  end

  def neighbors(board)
    neighbors_arr = pos.surround
    neighbors_arr.reject! {|pos| (pos[0]<0 || pos[0]>= board.grid[0].length)}
    neighbors_arr.reject! {|pos| (pos[1]<0 || pos[1]>= board.grid.length)}
    neighbors_arr.map! {|pos| board[pos]}
  end

  def neighbor_bomb_count(board)
    neighbor_bombs = 0
    neighbors(board).each do |tile|
      neighbor_bombs += 1 if tile.bombed
    end
    @bombs_nearby = neighbor_bombs
  end

end

class Array
  def subsets
    return [[]] if empty?
    subs = take(count - 1).subsets
    subs.concat(subs.map { |sub| sub + [last] })
  end

  def surround
    options = [1,-1,0,1,-1].subsets.select {|arr| arr.length == 2}.uniq
    options.map { |el| [self,el].transpose.map {|x| x.reduce(:+)} }
  end
end
