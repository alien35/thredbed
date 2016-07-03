module NotificationsHelper
  def new_notifs(current_user)
    a = current_user.notifications.where(read: false).count
    a > 0 ? a : ""
  end
end
