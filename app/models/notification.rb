class Notification < ApplicationRecord
    #デフォルトの並び順を「作成日時の降順」で指定するdefault_scope
    default_scope -> { order(created_at: :desc) }
    belongs_to :favorite, optional: true
    belongs_to :post_comment, optional: true
    
    belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
