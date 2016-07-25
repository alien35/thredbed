class NotificationsController < ApplicationController
  before_action :count_tags

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    if @notification.notice_type == "started following you"
       redirect_to profile_path @notification.notified_by.user_name
    else
      redirect_to post_path @notification.post
    end
  end

  def index
    @notifications = current_user.notifications
    current_user.notifications.each do |notif|
      notif.update read: true
    end
  end


  def count_tags
      @tag_counts = Post.where("created_at > ?", Time.now - 5.days).tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
    end


end
