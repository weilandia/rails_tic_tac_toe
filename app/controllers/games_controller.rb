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

  def last_move
    @last_move = Game.find(game_params).moves.last
    respond_to do |format|
      format.json { render json: @last_move }
    end
  end

private
  def game_params
    params.permit(:move, :id)
  end
end
