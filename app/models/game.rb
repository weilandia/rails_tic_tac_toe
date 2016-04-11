class Game
  attr_reader :moves
  attr_accessor :last_move, :current_player

  def initialize(moves)
    @moves = moves || new_board
  end

  def add_move(game_params)
    moves[game_params["move"]] = current_player
    self.last_move = game_params["move"]
  end

  def make_move(game_params)
    self.current_player = game_params["player"]
    if current_player == "x"
      add_move(game_params)
    else
      computer_move
    end
  end

  def computer_move
    return add_move({"move" => "5", "player" => "o"}) if center_open?
    return go_for_win if !win_line.empty?
    return block if !danger_line.empty?
    attack
  end

  def smart_move(line)
    coordinate = line.values.flatten.index(nil)
    move = win_lines[line.keys.first][coordinate]
    add_move({"move" => move, "player" => current_player})
  end

  def attack
    return add_move({"move" => fork_line, "player" => current_player}) if fourth_move? && opponent_forked_corners?
    return add_move({"move" => move_line, "player" => current_player}) if open_corners.empty?
    return opportunity if !opportunity_line.empty?
    add_move({"move" => open_corners.keys.sample, "player" => current_player})
  end

  def move_line
    check_move(check_lines(1))
  end

  def fourth_move?
    moves.values.compact.length == 3
  end

  def opponent_forked_corners?
    moves["1"] == on_deck_player && moves["9"] == on_deck_player || moves["3"] == on_deck_player && moves["7"] == on_deck_player
  end

  def check_corners
    moves.select do |move, player|
      player == on_deck_player && corners.include?(move)
    end
  end

  def open_corners
     moves.select do |move, player|
      corners.include?(move) && open_spaces.include?(move)
    end
  end

  def corners
    ["1", "3", "7", "9"]
  end

  def fork_line
    "4"
  end

  def go_for_win
    smart_move(win_line)
  end

  def block
    smart_move(danger_line)
  end

  def opportunity
    smart_move(opportunity_line)
  end

  def win_line
    check_win(check_lines(2))
  end

  def danger_line
    check_danger(check_lines(2))
  end

  def opportunity_line
    check_opportunity(check_lines(1))
  end

  def check_opportunity(lines)
    lines.select do |_line, players|
       players.compact == [current_player]
    end
  end

  def check_lines(n)
    lines.select do |_line, players|
      players.compact.length == n
    end
  end

  def check_win(lines)
    lines.select do |_line, players|
       players.compact == [current_player, current_player]
    end
  end

  def check_danger(lines)
    lines.select do |_line, players|
       players.compact == [on_deck_player, on_deck_player]
    end
  end

  def open_spaces
    moves.select do |move, player|
      player == nil
    end
  end

  def on_deck_player
    if current_player == "x" then "o"
    else "x"
    end
  end

  def center_open?
    open_spaces.include?("5")
  end

  def open?(space)
    open_spaces.include?(space)
  end

  def win?(player)
    win_lines.values.each do |win_line|
      win = win_line.select do |move|
        moves[move] == player
      end
      return winner(player) if win.sort == win_line
    end
    false
  end

  def winner(player)
    if player == "o"
      "you shouldn't have lost, but you did..."
    else
      "you won...and found a bug (if you could, please email a screenshot of your game to nickweiland@gmail.com thx!!)"
    end
  end

  def draw?
    open_spaces.length == 0
  end

  def win_lines
    { r1: ["1", "2", "3"],
      r2: ["4", "5", "6"],
      r3: ["7", "8", "9"],
      c1: ["1", "4", "7"],
      c2: ["2", "5", "8"],
      c3: ["3", "6", "9"],
      d1: ["1", "5", "9"],
      d2: ["3", "5", "7"]
    }
  end

  def lines
    { r1: [moves["1"], moves["2"], moves["3"]],
      r2: [moves["4"], moves["5"], moves["6"]],
      r3: [moves["7"], moves["8"], moves["9"]],
      c1: [moves["1"], moves["4"], moves["7"]],
      c2: [moves["2"], moves["5"], moves["8"]],
      c3: [moves["3"], moves["6"], moves["9"]],
      d1: [moves["1"], moves["5"], moves["9"]],
      d2: [moves["3"], moves["5"], moves["7"]]
    }
  end

  def opposite_corners
    { "1" => ["3", "7", "9"],
      "3" => ["1", "7", "9"],
      "7" => ["1", "3", "9"],
      "9" => ["1", "3", "7"]
      }
  end

  def new_board
    { "1" => nil,
      "2" => nil,
      "3" => nil,
      "4" => nil,
      "5" => nil,
      "6" => nil,
      "7" => nil,
      "8" => nil,
      "9" => nil
    }
  end
end
