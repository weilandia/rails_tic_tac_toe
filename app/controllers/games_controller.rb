class GamesController < ApplicationController
  def create
    @game = Game.create
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(game_params[:id])
  end

  def update
    @game = Game.find(game_params[:id])
    @game.make_move(game_params[:move])
    render :show
  end

private
  def game_params
    params.permit(:move, :id)
  end
end
