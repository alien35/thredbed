class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_confirmed
def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    create_notification(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

    def create_notification(user)
    Notification.create(user_id: user.id,
                        notified_by_id: current_user.id,
                        identifier: user.id,
                        notice_type: 'started following you')
    end

    def verify_confirmed
      unless current_user.confirmed?
        flash[:alert] = "Please confirm your email first"
        redirect_to :back
      end
    end



end
