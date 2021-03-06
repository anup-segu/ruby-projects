require './tile'
require 'colorize'

class Board
  attr_accessor :grid, :bomb_count

  def initialize(grid = Array.new(9) {|x| Array.new(9) {|y| Tile.new(x,y)}})
    @grid = grid
    @bomb_count = grid.length ** 2 / grid.length #(grid.length..grid.length * 3).to_a.sample
  end

  def solved?
    @grid.flatten.reject { |tile| tile.bombed }.all? { |tile| tile.revealed }
  end

  def over?
    @grid.flatten.any? { |tile| tile.bombed && tile.revealed }
  end

  def seed_bombs(bomb_count)
    until bomb_count == 0
      x = (0...grid.length).to_a.sample
      y = (0...grid.length).to_a.sample
      pos = [x, y]
      if self[pos].bombed
        next
      else
        self[pos].bombed = true
        bomb_count -= 1
      end
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = grid[x][y]
    tile.value = value
  end

  def render
    puts "   " + (0...grid.length).to_a.join("  ")
    grid.each_with_index do |row, i|
      puts "#{i} [#{row.join("][")}]"
    end
  end

  def reveal_all
    grid.flatten.each { |tile| tile.reveal(self) }
  end


end
