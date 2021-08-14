class SearchController < ApplicationController
    def search
        @faculty = params[:faculty]
        @search = params[:search]
        @text = params[:text]
        if @faculty == 'User'
          @users = User.search(params[:search],params[:text])
        else
          @books = Book.search(params[:search],params[:text])
        end
    end
end
