class BooksController < ApplicationController
    def index
        @book = Book.new
        @books = Book.all
        @user = current_user
    end
    
    def show
        @book_new = Book.new
        @book = Book.find(params[:id])
        @user = @book.user
        @post_comment = PostComment.new
        @post_comments = @book.post_comments
    end
    
    def edit
        @book = Book.find(params[:id])
        if @book.user.id != current_user.id
            redirect_to books_path
        end
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
        if @book.update(book_params)
            redirect_to book_path
        else
            render :edit
        end
    end
    
    private
    def book_params
        params.require(:book).permit(:title,:body)
    end
    def user_params
        params.require(:user).permit(:name,:introduction,:profile_image)
    end
end
