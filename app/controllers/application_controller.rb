class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def notif_title_count
    user_signed_in? ? "(#{user.notifications.count}) Comlink" : "Comlink"
  end
end
