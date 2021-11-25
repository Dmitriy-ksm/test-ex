class ApplicationController < ActionController::Base
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

private 

    def if_admin_boolean
        !current_user.nil? && User.roles[current_user.role] == User.roles["admin"]
    end

    def layout_check 
        if_admin_boolean ? "admin" : "application"
    end
end
