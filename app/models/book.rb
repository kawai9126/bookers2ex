class Book < ApplicationRecord
    attachment :image
    
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
    
    def self.search(search,text)
        if search == "partial_match"
            @book = Book.where("title like ?","%#{text}%")
        else
            @book = Book.all
        end
    end
end
