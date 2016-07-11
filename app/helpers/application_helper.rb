module ApplicationHelper

  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end



  def profile_avatar_select(user)
  return image_tag user.avatar.url(:medium),
                   id: 'image-preview',
                   class: 'img-responsive img-circle profile-image' if user.profile_pic.exists?
  image_tag 'default-avatar.jpg', id: 'image-preview',
                                  class: 'img-responsive img-circle profile-image'
  end

  def notif_title_count
    return "Comlink" unless user_signed_in?
    a = current_user.notifications.where(read:false).count
    a > 0 ? "(#{a}) Comlink" : "Comlink"

  end

  def user_bio(post_user)
    a = post_user.user_name
    post_user.bio.nil? ? a : a + ", " + "#{post_user.bio}"
  end



end
