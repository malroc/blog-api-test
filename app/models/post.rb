class Post < ApplicationRecord
  validates :body, presence: true

  has_many :likes, dependent: :destroy
end
