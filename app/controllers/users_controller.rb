class UsersController < ApplicationController
    def index
        @users = User.all
        @user = current_user
        @book = Book.new
    end
    
    def show
        @user = User.find(params[:id])
        @books = @user.books.all
    end
    
    
    def edit
        @user = User.find(params[:id])
        if @user.id != current_user.id
            redirect_to user_path(current_user)
        end
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
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
