class Board
  attr_accessor :grid
  def initialize(grid = Array.new(9) {Array.new(9)})
    @grid = grid
    @bomb_count = (grid.length..grid.length * 3).to_a.sample
  end

  def seed_bombs(bomb_count)
    until bomb_count == 0
      x = (0...grid.length).to_a.sample
      y = (0...grid.length).to_a.sample
      if self[x, y].bombed?
        next
      else
        self[x, y].bombed? = true
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


end
