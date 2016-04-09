class Move < ActiveRecord::Base
  has_many :game_moves
  has_many :games, through: :game_moves
end
