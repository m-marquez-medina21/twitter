class ApplicationController < ActionController::Base
    before_action :banned?
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    
    def banned?
        if current_user.present? && current_user.banned?
            sign_out current_user
            flash[:error] = 'te bloqueamos'
            root_path
        end
    end

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :user_photo])
    end
end
