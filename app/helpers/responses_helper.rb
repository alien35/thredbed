module ResponsesHelper

  def likers_of(response)
    votes = response.votes_for.up.by_type(User)
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

  def liked_response(response)
    return 'glyphicon-liked' if current_user.voted_for? response
    'glyphicon-unliked'
  end

  private

  def like_plural(votes)
    return votes.count > 1 ? ' like this' : ' likes this'
  end

  def dislike_plural(votes)
    return votes.count > 1 ? ' dislike this' : ' dislikes this'
  end

  def display_response_likes(response)
    votes = response.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  def display_response_dislikes(response)
    votes = response.votes_for.down.by_type(User)
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
      user_names.to_sentence.html_safe + like_plural(votes)
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
      user_names.to_sentence.html_safe + dislike_plural(votes)
    end
  end

end
