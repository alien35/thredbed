module CommentsHelper

  def comment_count
    case @post.comments.count
    when 0
      return "Be the first to comment."
    when 1
      return "There is 1 comment so far."
    else
       "There are " +  @post.comments.count.to_s + " comments so far."
    end
  end

  def comment_count_index(post)
    case post.comments.count
    when 0
      return "Be the first to comment."
    when 1
      return "1 comment"
    else
      post.comments.count.to_s + " comments"
    end
  end

  def likers_of(comment)
    votes = comment.votes_for.up.by_type(User)
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

  def liked_comment(comment)
    return 'glyphicon-liked' if current_user.voted_for? comment
    'glyphicon-unliked'
  end

  private

  def like_plural(votes)
    return ' likes this'
  end

  def dislike_plural(votes)
    return ' dislikes this'
  end

  def display_comment_likes(comment)
    votes = comment.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  def display_comment_dislikes(comment)
    votes = comment.votes_for.down.by_type(User)
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
