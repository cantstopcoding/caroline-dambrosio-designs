class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new
        end
    end

    def show
        # use find_by instead of find because find will throw up error 
        # and find_by will return nil
        @user = User.find_by(id: params[:id])
        redirect_to '/' if !@user
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end

end
