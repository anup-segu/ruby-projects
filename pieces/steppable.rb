module Steppable

  KNIGHT_DIR = [
    [-1,2],
    [-1,-2],
    [-2,1],
    [-2,-1],
    [2,1],
    [2,-1],
    [1,2],
    [1,-2]
  ]

  KING_DIR = [
    [-1,1],
    [-1,-1],
    [-1,0],
    [0,-1],
    [1,1],
    [1,-1],
    [1,0],
    [0,1]
  ]

  def knight_dir
    KNIGHT_DIR
  end

  def king_dir
    KING_DIR
  end

  def moves_on_board
    moves = []

    move_dir.each do |dir_row, dir_col|
      row, col = self.position

      row, col = row + dir_row, col + dir_col
      new_pos = [row, col]

      next unless @board.in_bounds?(new_pos)

      if @board.has_piece?(new_pos) && @board[new_pos].color == color
        next
      elsif @board.has_piece?(new_pos)
        moves << new_pos
        next
      else
        moves << new_pos
      end
    end

    moves
  end

end
