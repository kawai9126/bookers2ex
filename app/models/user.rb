class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         attachment :profile_image
         
        has_many :books
        has_many :favorites, dependent: :destroy
        has_many :post_comments, dependent: :destroy
         
        #チャットの 
        has_many :user_rooms
        has_many :chats
        
        #通知の
        #自分からの通知
        has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
        #相手からの通知
        has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
         
         
         
        # 自分がフォローされる（被フォロー）側の関係性
        has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
        # 自分がフォローする（与フォロー）側の関係性
        has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
        # 被フォロー関係を通じて参照→自分をフォローしている人
        has_many :followers, through: :reverse_of_relationships, source: :follower
        # 与フォロー関係を通じて参照→自分がフォローしている人
        has_many :followings, through: :relationships, source: :followed
        
        def follow(user_id)
            relationships.create(followed_id: user_id)
        end

        def unfollow(user_id)
            relationships.find_by(followed_id: user_id).destroy
        end

        def following?(user)
            followings.include?(user)
        end
        
        def self.search(search,name)
            if search == "partial_match"
                @user = User.where("name like ?","%#{name}%")
            else
                @user = User.all
            end
        end
        
        def create_notification_favorite!(current_user)
            # いいねされているか検索
            temp = Notification.where(["visitor_id = ? and visited_id = ? and favorite_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
            # いいねされていない場合のみ、通知を作成
            if temp.blank?
                notification = current_user.active_notifications.new(
                favorite_id: id,
                visited_id: user_id,
                action: 'like'
                )
            # 自分の投稿に対するいいねの場合は、通知済みにして通知が来ないように
                if notification.visitor_id == notification.visited_id
                    notification.checked = true
                end
                notification.save if notification.valid?
            end
        end
end
