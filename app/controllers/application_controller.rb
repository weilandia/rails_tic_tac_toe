class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_board

  def set_board
    @board = session[:board]
  end
end
