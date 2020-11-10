class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protect_from_forgery

    devise_group :user, contains: [:student, :professor]

    # around_action :set_time_zone, if: :current_user

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email, :password, :password_confirmation])
    end


end
