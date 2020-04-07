json.extract! post,
              :id,
              :body,
              :likes_count,
              :created_at,
              :updated_at,
              :commented_at

json.is_liked post.likes.find_by(user: current_user).present?
json.url post_url(post, format: :json)
