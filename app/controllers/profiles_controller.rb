class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :profile_owner, only: [:edit, :update]
  before_action :count_tags
  before_action :verify_confirmed



  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def verify_confirmed
      unless current_user.confirmed?
        flash[:alert] = "Please confirm your email first"
        redirect_to :back
      end
    end

  def profile_params
    params.require(:user).permit(:avatar, :bio, :occupation)
  end

  def profile_owner
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def count_tags
      @tag_counts = Post.where("created_at > ?", Time.now - 5.days).tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
    end

  def follow_25

  end

end
