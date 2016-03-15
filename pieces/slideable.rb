module Slideable

  ORTHAGONAL_DIR = [
    [-1,0],
    [1,0],
    [0,-1],
    [0,1]
  ]

  DIAGONAL_DIR = [
    [-1,1],
    [-1,-1],
    [1,1],
    [1,-1]
  ]

  def orthagonal_dir
    ORTHAGONAL_DIR
  end

  def diagonal_dir
    DIAGONAL_DIR
  end

  def moves_on_board
    moves = []

    move_dir.each do |dir_row, dir_col|
      row, col = self.position

      loop do
        row, col = row + dir_row, col + dir_col
        new_pos = [row, col]

        break unless @board.in_bounds?(new_pos)

        if @board.has_piece?(new_pos) && @board[new_pos].color == color
          break
        elsif @board.has_piece?(new_pos)
          moves << new_pos
          break
        else
          moves << new_pos
        end
      end
    end

    moves
  end

end
