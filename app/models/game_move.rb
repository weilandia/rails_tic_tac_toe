class GameMove < ActiveRecord::Base
  belongs_to :game
  belongs_to :move
end
