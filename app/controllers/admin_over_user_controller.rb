class AdminOverUserController < ApplicationController

    before_action :check_if_admin
    before_action  :find_user, only: [:edit, :update]
    
    def index
        @users = User.all
    end

    def edit
    end

    def update
        @user.update(users_params)
        if @user.errors.empty?
            redirect_to action: "index"
        else
            render "edit"
        end
    end

    private
        
    def users_params
        params.require(:user).permit(:first_name, :last_name)
    end

        def find_user
            @user =  User.where(id: params[:id]).first
            render_404 unless @user
        end
    
end
