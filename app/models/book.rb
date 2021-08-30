class Book < ApplicationRecord
    attachment :image
    
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
    
    def self.search(search,text)
        if search
            @book = Book.where("title like ?","%#{text}%")
        else
            @book = Book.none
        end
    end
    
    def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
            book_id: id,
            visited_id: user_id,
            action: "fovorite"
        )
        notification.save if notification.valid?
    end
end
