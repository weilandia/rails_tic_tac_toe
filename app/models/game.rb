class Game < ActiveRecord::Base
  has_many :game_moves
  has_many :moves, through: :game_moves

  def make_move(move)
    plot_move(move, "x")
    computer_move
  end

  def plot_move(move, player)
    GameMove.create(game_id: self.id, move_id: Move.find(move).id, player: player)
  end

  def computer_move
    return plot_move(5, "o") if center_open?
    return go_for_win if !win_line.nil?
    return block if !danger_line.nil?
    attack
  end

  def open_spaces
    (1..9).reject { |space|  Game.last.moves.pluck(:id).include?(space) }
  end

  def center_open?
    open_spaces.include?(5)
  end

  def open?(space)
    open_spaces.include?(space)
  end
end
