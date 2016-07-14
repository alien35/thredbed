module PostsHelper

  def title_max_length(str)
    str.split("").length > 100 ?
    str.split("")[0...100].join("") + "..." : str
  end

  def caption_max_length(str)
    str.split("").length > 300 ?
    str.split("")[0...300].join("") + "..." : str
  end

  def likers_of(post)
    votes = post.votes_for.up.by_type(User)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def liked_post(post)
    return 'glyphicon-liked' if current_user.voted_for? post
    'glyphicon-unliked'
  end

  private

  def post_like_plural(votes)
    return ' likes this'
  end

  def post_dislike_plural(votes)
    return ' dislikes this'
  end

  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  def display_dislikes(post)
    votes = post.votes_for.down.by_type(User)
    return list_dislikers(votes) if votes.size <= 8
    count_dislikers(votes)
  end

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + post_like_plural(votes)
    end
  end

  def list_dislikers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + post_dislike_plural(votes)
    end
  end


end
