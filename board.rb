require_relative 'pieces'

class Board
  attr_accessor :grid

  def initialize(fill = false)
    @grid = Array.new(8) { Array.new(8, nil) }
    if fill
      self.populate_full
    else
      self.populate_blank
    end
  end

  def populate_blank
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |space, space_idx|
        space = NullPiece.new(self, [row_idx, space_idx])
      end
    end
  end

  def populate_full
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |space, space_idx|
        if row_idx == 1 || row_idx == 6
          color = row_idx % 2 == 0 ? :white : :black
          space = Pawn.new(self, [row_idx, space_idx], color)
          # space = NullPiece.new(self, [row_idx, space_idx])
        elsif row_idx == 0 || row_idx == 7
          color = row_idx == 0 ? :black : :white
          case space_idx
          when 0, 7
            space = Rook.new(self, [row_idx, space_idx], color)
          when 1, 6
            space = Knight.new(self, [row_idx, space_idx], color)
          when 2, 5
            space = Bishop.new(self, [row_idx, space_idx], color)
          when 3
            space = Queen.new(self, [row_idx, space_idx], color)
          when 4
            space = King.new(self, [row_idx, space_idx], color)
          end
        else
          space = NullPiece.new(self, [row_idx, space_idx])
        end

      end
    end
  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0,@grid.length-1) &&
      y.between?(0,@grid[0].length-1)
  end

  def move(start_pos, end_pos)
    starting_piece = self[start_pos]
    raise ArgumentError.new("Starting position is empty") if starting_piece.nil?
    ending_piece = self[end_pos]
    raise ArgumentError.new("Starting position is empty") if !ending_piece.nil? && ending_piece.color == starting_piece.color

    self[end_pos] = starting_piece
    self[start_pos] = nil
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, target)
    x,y = pos
    @grid[x][y] = target
  end

  def has_piece?(pos)
    !(self[pos].is_a?(NullPiece))
  end

end
