module UsersHelper

  def follow_num(post_user)
    if post_user.followers.count < 25
      "follow_0"
    elsif post_user.followers.count < 50
      "follow_25"
    elsif post_user.followers.count < 100
      "follow_50"
    else
      "follow_100"
    end
  end


end
