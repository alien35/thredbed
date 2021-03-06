class ResponsesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :like, :dislike]
  before_action :verify_confirmed
  before_action :set_post
  before_action :owned_response, only: [:edit, :update, :destroy]

  def create
    @response = @comment.responses.build(response_params)
    @response.user_id = current_user.id
    @response.post_id = @comment.post_id

    if @response.save
      create_notification @comment, @response
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

  def like
    @response = @comment.responses.find(params[:id])
    @response.upvote_by current_user
    create_upvote_notification @comment, @response
    respond_to do |format|
      format.js { render "response_like.js.erb" }
    end
  end

  def dislike
    @response = @comment.responses.find(params[:id])
    @response.downvote_by current_user
    respond_to do |format|
      format.js { render "response_dislike.js.erb" }
    end
  end

  def unlike
    @response = @comment.responses.find(params[:id])
    @response.unvote_by current_user
    respond_to do |format|
      format.js { render "response_dislike.js.erb" }
    end
  end

  private

    def verify_confirmed
      unless current_user.confirmed?
        flash[:alert] = "Please confirm your email first"
        redirect_to :back
      end
    end

    def create_notification(comment, response)
    return if response.user.id == current_user.id
    Notification.create(user_id: comment.user.id,
                        notified_by_id: current_user.id,
                        post_id: comment.post.id,
                        comment_id: comment.id,
                        identifier: response.id,
                        notice_type: 'replied to your comment')
    end

    def create_upvote_notification(comment, response)
    #return if response.user.id == current_user.id
    Notification.create(user_id: response.user.id,
                        notified_by_id: current_user.id,
                        post_id: comment.post.id,
                        comment_id: comment.id,
                        identifier: response.id,
                        notice_type: 'likes your reply')
    end




    def response_params
      params.require(:response).permit(:content)
    end

    def set_post
      @comment = Comment.find(params[:comment_id])
      @post = @comment.post_id
    end

    def owned_response
      unless current_user == @post.user
        flash[:alert] = "That post doesn't belong to you!"
        redirect_to root_path
      end
    end

end
