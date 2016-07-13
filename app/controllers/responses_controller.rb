class ResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @response = @comment.responses.build(response_params)
    @response.user_id = current_user.id

    if @response.save
    #  create_notification @post, @comment
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      flash[:alert] = 'Check the comment form, something went wrong.'
      render :back
    end
  end



  def destroy
    @response = @comment.responses.find(params[:id])
    if @response.user_id == current_user.id
      @response.delete
      respond_to do |format|
        format.html { redirect_to :back}
        format.js
      end
    end
  end

  def upvote
    @response = @comment.responses.find(params[:id])
    @response.upvote_by current_user
    create_upvote_notification @comment, @response
    redirect_to :back
  end

  def downvote
    @response = @comment.responses.find(params[:id])
    @response.downvote_by current_user
    redirect_to :back
  end

  def unvote
    @response = @comment.responses.find(params[:id])
    @response.unvote_by current_user
    redirect_to :back
  end

  private

    def create_notification(post, comment)
    return if post.user.id == current_user.id
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: comment.id,
                        notice_type: 'commented on your post')
    end

    def create_upvote_notification(post, comment)
    return if post.user.id == current_user.id
    Notification.create(user_id: comment.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: comment.id,
                        notice_type: 'likes your comment')
    end




    def response_params
      params.require(:response).permit(:content)
    end

    def set_post
    @comment = Comment.find(params[:comment_id])
    end

end
