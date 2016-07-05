module NotificationsHelper
  def new_notifs(current_user)
    a = current_user.notifications.where(read: false)
    a.count > 0 ? a.count : ""

  end


end
