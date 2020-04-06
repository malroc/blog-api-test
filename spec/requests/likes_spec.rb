describe "/posts/:post_id/like" do
  let(:valid_attributes) { {} }
  let(:valid_headers) { {} }

  describe "GET /show" do
    let!(:like) { create(:like) }

    it "renders a successful response" do
      get post_like_url(like.post_id), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "when like doesn't exist" do
      let!(:url) { post_like_url(create(:post).id) }

      it "creates a new Like" do
        expect do
          post url,
               params: { like: valid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Like, :count).by(1)
      end

      it "renders a JSON response with the new like" do
        post url,
             params: { like: valid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).
          to match("application/json")
      end
    end

    context "when like exists" do
      let!(:like) { create(:like) }
      let!(:url) { post_like_url(like.post.id) }

      it "does not create a new Like" do
        expect do
          post url,
               params: { like: valid_attributes },
               as: :json
        end.to change(Like, :count).by(0)
      end

      it "renders a JSON response with the existing like" do
        post url,
             params: { like: valid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:found)
        expect(response.content_type).to match("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:like) { create(:like) }

    it "destroys the requested like" do
      expect do
        delete post_like_url(like.post_id), headers: valid_headers, as: :json
      end.to change(Like, :count).by(-1)
    end
  end
end
