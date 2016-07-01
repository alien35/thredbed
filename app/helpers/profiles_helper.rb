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


end
