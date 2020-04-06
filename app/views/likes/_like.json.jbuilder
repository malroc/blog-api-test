json.extract! like, :id, :user_id, :post_id, :created_at, :updated_at
json.url post_like_url(like.post_id, format: :json)
