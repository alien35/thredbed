class RegistrationsController < Devise::RegistrationsController
before_action :count_tags



private

    def sign_up_params
        params.require(:user).permit(:user_name, :email, :password,
                                     :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:user_name, :email, :password,
                  :password_confirmation, :current_password)
    end

    def count_tags
      @tag_counts = Post.where("created_at > ?", Time.now - 5.days).tag_counts_on(:tags)
                      .order('count desc')
                      .limit(10)
    end


end
