class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update, :like, :dislike, :unlike]
  before_action :verify_confirmed, only: [:new, :create, :delete, :like, :dislike, :edit, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :dislike, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]
  before_action :count_tags


  def index
    if user_signed_in?
      @posts = Post.paginate(page: params[:page], per_page: 36)
                 .where("created_at > ?", Time.now - 5.days)
                 .order(cached_votes_up: :desc)
    else
      if Post.count > 20
      @posts = Post.paginate(page: params[:page], per_page: 36)
                 .where("created_at > ?", Time.now - 5.days)
                 .order(cached_votes_up: :desc)
      else
      @posts = nil
      end
    end
      if params[:search]
        @posts = Post.paginate(page: params[:page], per_page: 36)
                 .search(params[:search]).order("created_at DESC")
      elsif params[:tag]
        @posts = Post.paginate(page: params[:page], per_page: 36)
                     .tagged_with(params[:tag])
                     .order(cached_votes_up: :desc)
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

  def like
    @post.upvote_by current_user
    respond_to do |format|
      format.js { render "like.js.erb" }
    end
    create_upvote_notification @post

  end

  def dislike
    @post.downvote_by current_user
    respond_to do |format|
      format.js { render "dislike.js.erb" }
    end
  #  create_downvote_notification @post
  end

  def unlike
    @post.unvote_by current_user
    respond_to do |format|
      format.js { render "dislike.js.erb"}

    end
  end

  def more_posts
    Post.paginate(page: params[:page], per_page: 12).order(cached_weighted_total: :desc)
  end

  private

    def verify_confirmed
      unless current_user.confirmed?
        flash[:alert] = "Please confirm your email first"
        redirect_to :back
      end
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:link, :image, :commentary, :tag_list, :image_link)
    end

    def update_params
      params.require(:post).permit(:image, :commentary)
    end

    def owned_post
      unless current_user == @post.user
        flash[:alert] = "That post doesn't belong to you!"
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
      @tag_counts = Post.where("created_at > ?", Time.now - 5.days).tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
    end

end
