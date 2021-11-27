class ApplicationController < ActionController::Base
    
    #protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    layout :layout_check


    def render_403
        render file: "public/403.html", status: 403
    end

    def render_404
        render file: "public/404.html", status: 404
    end

    def check_if_admin
        render_403 unless if_admin_boolean
    end

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
            devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
            #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password) }
            #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password) }
        end

    private 

        def is_login 
            !current_user.nil?
        end 

        def if_admin_boolean
            !current_user.nil? && User.roles[current_user.role] == User.roles["admin"]
        end

        def layout_check 
            if_admin_boolean ? "admin" : "application"
        end
end
