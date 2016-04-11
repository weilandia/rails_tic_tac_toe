class GameController < ApplicationController

  def index
    if game_params[:player] && @game.win?(game_params[:player])
      flash[:info] = "#{@game.win?(game_params[:player])}"
      flash.keep(:info)
      reset_session
      render js: "window.location = '#{root_path}'"
    elsif game_params[:player] && @game.draw?
      flash[:info] = "an unlikely draw..."
      flash.keep(:info)
      reset_session
      render js: "window.location = '#{root_path}'"
    else
      render :index
    end
  end

  def new
    session[:game] = nil
    redirect_to root_path
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
