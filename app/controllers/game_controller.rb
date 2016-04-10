class GameController < ApplicationController

  def index
  end

  def update
    @game.make_move(game_params)
    session[:game] = @game.moves
    render :index
  end

private
  def game_params
    params.permit(:move, :player)
  end
end
