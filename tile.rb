class Tile
  attr_accessor :flagged?, :bombed?, :revealed?
  def initialize(bombed = false)
    @bombed? = bombed
    @flagged? = false
    @revealed? = false
  end

  def reveal
    revealed? = true
  end

  def to_s
    case
    when bombed? && revealed?
      "B"
    when flagged? && !(revealed?)
      "F"
    when revealed?
      neighbor_bomb_count.to_s
    else
      " "
    end
  end

  def neighbors
  end

  def neighbor_bomb_count
  end

end
