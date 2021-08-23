class Post < ApplicationRecord
    has_one :spot, dependent: :destroy
    accepts_nested_attributes_for :spot
end
