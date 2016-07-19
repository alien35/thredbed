class RegistrationsController < Devise::RegistrationsController
prepend_before_action :check_captcha, only: [:create]
before_action :count_tags

def create
      if verify_recaptcha
        super
      else
        build_resource
        clean_up_passwords(resource)
        flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
        render_with_scope :new
      end
    end

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
      @tag_counts = Post.tag_counts_on(:tags)
                        .order('count desc')
                        .limit(10)
    end

    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    end
end
