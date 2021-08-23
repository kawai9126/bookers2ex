class Video < ApplicationRecord
    #投稿に対して動画は一つ
    has_one_attached :video
end
