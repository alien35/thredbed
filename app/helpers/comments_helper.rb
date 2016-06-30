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

end
