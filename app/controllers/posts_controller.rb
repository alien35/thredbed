class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update, :upvote, :downvote, :unvote]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :unvote]
  before_action :post_owner, only: [:edit, :update, :destroy]
  before_action :count_tags


  def index
    if user_signed_in?
      @posts = Post.paginate(page: params[:page], per_page: 12)
                 .of_followed_users(current_user.following)
                 .where("created_at > ?", Time.now - 5.days)
                 .order(cached_weighted_total: :desc)
    else
      @posts = Post.paginate(page: params[:page], per_page: 12)
                 .order(cached_weighted_total: :desc)
    end
      if params[:search]
        @posts = Post.paginate(page: params[:page], per_page: 12)
                 .search(params[:search]).order("created_at DESC")
      elsif params[:tag]
        @posts = Post.paginate(page: params[:page], per_page: 12)
                     .tagged_with(params[:tag])
                     .order("created_at DESC")
      end



  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    current_user.posts << @post
    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Uh oh! Something went wrong. Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    @post.update(update_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def upvote
    @post.upvote_by current_user
    create_upvote_notification @post
    respond_to do |format|
  format.html { redirect_to :back }
  format.js
end
  end

  def downvote
    @post.downvote_by current_user
  #  create_downvote_notification @post
    respond_to do |format|
  format.html { redirect_to :back }
  format.js
end
  end

  def unvote
    @post.unvote_by current_user
    respond_to do |format|
  format.html { redirect_to :back }
  format.js
end
  end

  def more_posts
    Post.paginate(page: params[:page], per_page: 12).order(cached_weighted_total: :desc)
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:link, :commentary, :title, :tag_list)
    end

    def update_params
      params.require(:post).permit(:image, :commentary, :title)
    end

    def post_owner
      unless current_user = @post.user
        flash.now[:alert] = "That post doesn't belong to you"
        redirect_to root_path
      end
    end

    def create_upvote_notification(post)
    return if post.user.id == current_user.id
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: post.id,
                        notice_type: 'likes your post')
    end

    def count_tags
      @tag_counts = Post.tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
    end

end
