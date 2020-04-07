describe "/posts" do
  let(:valid_attributes) { attributes_for(:post) }

  let(:invalid_attributes) { { body: nil } }

  let(:valid_headers) { {} }

  describe "GET /index" do
    it "renders a successful response" do
      Post.create! valid_attributes
      get posts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    context "with like from current user" do
      let(:like) { create(:like) }

      it "shows that the post is liked" do
        get post_url(like.post), as: :json
        json = JSON.parse(response.body)
        expect(json["is_liked"]).to eq true
      end
    end

    context "with like from another user" do
      let(:like) { create(:like) }

      before { create(:user) }

      it "shows that the post is not liked" do
        get post_url(like.post), as: :json
        json = JSON.parse(response.body)
        expect(json["is_liked"]).to eq false
      end
    end

    context "with several likes" do
      let(:post_id) { create(:post).id }
      let(:likes_count) { rand(1..10) }

      before { create_list(:like, likes_count, post_id: post_id) }

      it "shows correct likes_count value" do
        get post_url(post_id), as: :json
        json = JSON.parse(response.body)
        expect(json["likes_count"]).to eq likes_count
      end
    end

    context "with no comments" do
      let(:post_id) { create(:post).id }

      it "shows empty commented_at value" do
        get post_url(post_id), as: :json
        json = JSON.parse(response.body)
        expect(json["commented_at"]).to be_nil
      end
    end

    context "with comment" do
      let(:comment) { create(:comment) }

      it "shows commented_at timestamp as string" do
        get post_url(comment.post), as: :json
        json = JSON.parse(response.body)
        expect(json["commented_at"]).to be_a String
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        expect do
          post posts_url,
               params: { post: valid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post posts_url,
             params: { post: valid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).
          to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect do
          post posts_url,
               params: { post: invalid_attributes },
               as: :json
        end.to change(Post, :count).by(0)
      end

      it "renders a JSON response with errors for the new post" do
        post posts_url,
             params: { post: invalid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { build(:post) }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        patch post_url(post),
              params: { post: new_attributes },
              headers: valid_headers,
              as: :json
        post.reload
        expect(post.body).to eq(new_attributes[:body])
      end

      it "renders a JSON response with the post" do
        post = Post.create! valid_attributes
        patch post_url(post),
              params: { post: new_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the post" do
        post = Post.create! valid_attributes
        patch post_url(post),
              params: { post: invalid_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect do
        delete post_url(post), headers: valid_headers, as: :json
      end.to change(Post, :count).by(-1)
    end
  end
end
