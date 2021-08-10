class UsersController < ApplicationController
    def index
        @users = User.all
        @user = current_user
        @book = Book.new
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def edit
        @user = User.find(params[:id])
        redirect_to user_path(@user.id)
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update
            redirect_to user_path(@user.id)
        else
            render :index
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:name,:introduction,:profile_image)
    end
    def book_params
        params.require(:book).permit(:image,:title,:body)
    end
end
