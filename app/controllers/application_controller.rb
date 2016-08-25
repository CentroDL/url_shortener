class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found
    render status: 404
  end

end
