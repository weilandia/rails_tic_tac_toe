class MovesController < ApplicationController
  def index
    @moves = Game.find(move_params[:game_id]).moves.pluck(:id)
    respond_to do |format|
      format.json { render json: @moves }
    end
  end

private
  def move_params
    params.permit(:game_id)
  end
end
