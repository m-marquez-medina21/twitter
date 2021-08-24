class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    
    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :user_photo])
    devise_parameter_sanitizer.permit(:update, keys: [:user_name, :user_photo])
    end
end
