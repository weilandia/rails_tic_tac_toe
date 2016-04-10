class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_game

  def set_game
    @game = Game.new(session[:game])
  end
end
