module UsersHelper

  def follow_num(post_user)
    if post_user.followers.count < 25
      "follow_0"
    else
      "follow_25"
    end
  end


end
