module Slideable
  #We wrote (-7..7) so that the argument to zip would fully map
  VERTICAL_MOVES = (-7..7).zip(-7..7).map { |x,y| [0, y]}.reject { |_,y| y == 0 }

  HORIZONTAL_MOVES = (-7..7).zip(0..0).map { |x,y| [x, 0]}.reject { |x,_| x == 0 }

  DIAGONAL_MOVES = (1..7).zip(1..7) +
    (1..7).zip((-7..-1).to_a.reverse) +
    (-7..-1).zip((1..7).to_a.reverse) +
    (-7..-1).zip(-7..-1)


  def valid_moves(pos)
    valid_moves = []

    mapped_moves(pos).each do |position|
      valid_moves << position if @board.in_bounds?(position)
    end

    valid_moves
  end

  def mapped_moves(pos)
    x,y = pos
    available_moves.map {|row, col| [row + x, col + y]}
  end

  # def open_moves(moves)
  #   (1..7).each do |shift|
  #     next_position = [@position[0]+shift, @position[1]]
  #     next if @board[next_position].is_a?(NullPiece)
  #     if @board.has_piece?(next_position)
  #       if @board[next_position].color == self.color
  #         right = moves.select {|x,y| if x < shift}
  #       end
  #     else
  #       right = moves.select {|x,y| if x <= shift}
  #     end
  #   end
  #
  #   (1..7).each do |shift|
  #     next_position = [@position[0]-shift, @position[1]]
  #     next if @board[next_position].is_a?(NullPiece)
  #     if @board.has_piece?(next_position)
  #       if @board[next_position].color == self.color
  #         left = moves.select {|x,y| if x > shift}
  #       end
  #     else
  #       left = moves.select {|x,y| if x >= shift}
  #     end
  #   end
  #
  #   right + left
  # end

end
