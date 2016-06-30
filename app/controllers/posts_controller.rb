class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 12).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
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
    flash[:success] = "Your post has been successfully updated!"
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end



  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:link, :commentary, :title)
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

end
