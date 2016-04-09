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
    return go_for_win if win_line
    return block if !danger_line.nil?
    attack
  end

  def go_for_win
    require "pry"; binding.pry
  end

  def win_line
    true
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

  def check_win(player)
    win_lines.each do |win_line|
      
    end
    game_moves.where(player: player).pluck(:id).select { |move|
      require "pry"; binding.pry
    }
  end

  def win_lines
    { r1: [1, 2, 3],
      r2: [4, 5, 6],
      r3: [7, 8, 9],
      c1: [1, 4, 7],
      c2: [2, 5, 8],
      c3: [3, 6, 9],
      d1: [1, 5, 9],
      d2: [3, 5, 7]
    }
  end
end
