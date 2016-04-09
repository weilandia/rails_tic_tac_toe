class MovesSeed
  def self.generate_moves
    all_moves.each { |move|
      Move.create(move: move)
    }
  end

private
  def self.all_moves
    ["00", "01", "02",
    "10", "11", "12",
    "20", "21", "22"]
  end
end

MovesSeed.generate_moves
