module NotificationsHelper
  def new_notifs(current_user)
    a = current_user.notifications.where(read: false)
    a.count > 0 ? a.count : ""

  end

  def all_notif_name
    "all_notif_name"
  end

end
