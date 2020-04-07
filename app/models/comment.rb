class Comment < ApplicationRecord
  validates :body, presence: true
  validates :post_id, presence: true

  belongs_to :post

  after_create :touch_post

  private

  def touch_post
    post.touch(:commented_at)
  end
end
