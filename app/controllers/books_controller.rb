class BooksController < ApplicationController
    def index
        @book = Book.new
        @books = Book.all
        @user = current_user
    end
    
    def show
        @book = Book.find(params[:id])
        @user = @book.user
    end
    
    def edit
        @book = Book.find(params[:id])
        redirect_to book_path(@book.id)
    end
    
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            redirect_to book_path(@book.id)
        else
            render :index
        end
    end
    
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end
    
    def update
        @book = Book.find(params[:id])
        if @book.update
            redirect_to book_path(@book.id)
        else
            render :edit
        end
    end
    
    private
    def book_params
        params.permit(:title,:body)
    end
    def user_params
        params.require(:user).permit(:name,:introduction,:profile_image)
    end
end
