class Game < ActiveRecord::Base
  has_many :game_moves
  has_many :moves, through: :game_moves

  def make_move(coordinate)
    plot_user_move(coordinate)
    computer_move
  end

  def computer_move
  end

  def plot_user_move(move)
    GameMove.create(game_id: id, move_id: Move.find_by(move: move).id, player: "x")
  end
end
