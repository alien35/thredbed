class UsersController < ApplicationController
  before_action :count_tags



  def index
    @users = User.all
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def count_tags
    @tag_counts = Post.tag_counts_on(:tags)
                    .order('count desc')
                    .limit(10)
  end

end
