class GameController < ApplicationController

  def index
  end

  def new
    session[:game] = nil
    redirect_to root_path
  end

  def update
    @game.make_move(game_params)
    session[:game] = @game.moves
    if @game.win?(game_params[:player])
      flash[:info] = "SOMEONE WON!"
      redirect_to "/game/new"
    else
      require "pry"; binding.pry
      render :index
    end
  end

private
  def game_params
    params.permit(:move, :player)
  end
end
