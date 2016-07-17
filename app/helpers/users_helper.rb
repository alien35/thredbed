module UsersHelper

  def follow_num(post)
    if post.user.followers.count < 25
      "follow_0"
    else
      "follow_25"
    end
  end


end
