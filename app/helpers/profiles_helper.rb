module ProfilesHelper
  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
                     class: 'profile-image' if user.avatar.exists?
    image_tag 'blank_profile_pic.png',
                                    class: 'profile-image'
  end

  def index_profile_avatar_select(user)
    return image_tag user.avatar.url(:thumb),
                     class: 'index-profile-image' if user.avatar.exists?
    image_tag 'blank_profile_pic.png',
                                    class: 'index-profile-image'
  end

  def show_profile_avatar_select(user)
    return image_tag user.avatar.url(:thumb),
                     class: 'index-profile-image' if user.avatar.exists?
    image_tag 'blank_profile_pic.png',
                                    class: 'show-profile-image'
  end

  def current_user_is_following(current_user_id, followed_user_id)
    relationship = Follow.find_by(follower_id: current_user_id, following_id: followed_user_id)
    return true if relationship
  end

end
