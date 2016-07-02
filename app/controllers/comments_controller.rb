class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      create_notification @post, @comment
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      flash.now[:alert] = "Check the comment form, something went wrong."
      render :show
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to :back}
        format.js
      end
    end
  end

  def upvote
    @comment = @post.comments.find(params[:id])
    @comment.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @comment = @post.comments.find(params[:id])
    @comment.downvote_by current_user
    redirect_to :back
  end

  def unvote
    @comment = @post.comments.find(params[:id])
    @comment.unvote_by current_user
    redirect_to :back
  end

  private

    def create_notification(post)
      return if post.user.id == current_user.id
      Notification.create(user_id: post.user.id,
                          notified_by_id: current_user.id,
                          post_id: post.id,
                          comment_id: comment.id,
                          notice_type: 'comment')
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
    @post = Post.find(params[:post_id])
    end

end
