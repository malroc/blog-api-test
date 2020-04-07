describe "/posts/:post_id/comments" do
  let(:post_id) { create(:post).id }
  let(:valid_attributes) { attributes_for(:comment, post_id: post_id) }
  let(:invalid_attributes) { { body: nil } }
  let(:valid_headers) { {} }

  describe "GET /index" do
    it "renders a successful response" do
      Comment.create! valid_attributes
      get post_comments_url(post_id), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      comment = Comment.create! valid_attributes
      get post_comment_url(post_id, comment), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect do
          post post_comments_url(post_id),
               params: { comment: valid_attributes },
               headers: valid_headers,
               as: :json
        end.to change(Comment, :count).by(1)
      end

      it "renders a JSON response with the new comment" do
        post post_comments_url(post_id),
             params: { comment: valid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match("application/json")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect do
          post post_comments_url(post_id),
               params: { comment: invalid_attributes }, as: :json
        end.to change(Comment, :count).by(0)
      end

      it "renders a JSON response with errors for the new comment" do
        post post_comments_url(post_id),
             params: { comment: invalid_attributes },
             headers: valid_headers,
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { attributes_for(:comment, post_id: nil) }

      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        patch post_comment_url(post_id, comment),
              params: { comment: new_attributes },
              headers: valid_headers,
              as: :json
        comment.reload
        expect(comment.body).to eq new_attributes[:body]
      end

      it "renders a JSON response with the comment" do
        comment = Comment.create! valid_attributes
        patch post_comment_url(post_id, comment),
              params: { comment: new_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the comment" do
        comment = Comment.create! valid_attributes
        patch post_comment_url(post_id, comment),
              params: { comment: invalid_attributes },
              headers: valid_headers,
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect do
        delete post_comment_url(post_id, comment),
               headers: valid_headers,
               as: :json
      end.to change(Comment, :count).by(-1)
    end
  end
end
