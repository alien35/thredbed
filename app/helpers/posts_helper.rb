module PostsHelper



  def index_commentary_shrink(str)
    str.gsub("<br>", " ")
     .gsub(/<img.+>/, "")
     .gsub('a target="_blank" rel="nofollow" href="', "")
     .gsub('<\a>', "")
     .split("").length > 150 ?
    str.split("")[0...150].join("") + "..." : str
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
    return list_likers(votes) if votes.size <= 4
    count_likers(votes)
  end

  def display_dislikes(post)
    votes = post.votes_for.down.by_type(User)
    return list_dislikers(votes) if votes.size <= 4
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

  def count_likers(votes)
    user_names = []
    votes.voters.take(2).each do |voter|
      user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
    "#{user_names.first}, #{user_names.last} and #{votes.size - 2} others like this".html_safe
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end

  def count_dislikers(votes)
    vote_count = votes.size
    (vote_count - 2).to_s + ' others dislike this'
  end

  def dislike_plural(votes)
    return ' dislike this' if votes.count > 1
    ' dislikes this'
  end


end
