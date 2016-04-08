class GameController < ApplicationController
  def create
    game = Game.create
    session[:board] = Board.new
    redirect_to game_path
    require "pry"; binding.pry
  end

  def update
    require "pry"; binding.pry
  end
end
