class PoroBoard
  def initialize(args = {}, move = nil)
    @board = build_board(args["board"], move)
  end

  def build_board(board, move)
    if board
      move = move.chars.map(&:to_i)
      board[move.first][move.last] = "x"
      board
    else
      Array.new(3) { Array.new(3) { nil } }
    end
  end
end
