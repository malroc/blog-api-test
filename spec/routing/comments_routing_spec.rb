describe CommentsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/posts/1/comments").
        to route_to("comments#index", post_id: "1", format: :json)
    end

    it "routes to #show" do
      expect(get: "/posts/1/comments/1").
        to route_to("comments#show", post_id: "1", id: "1", format: :json)
    end

    it "routes to #create" do
      expect(post: "/posts/1/comments").
        to route_to("comments#create", post_id: "1", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "/posts/1/comments/1").
        to route_to("comments#update", post_id: "1", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/posts/1/comments/1").
        to route_to("comments#update", post_id: "1", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/posts/1/comments/1").
        to route_to("comments#destroy", post_id: "1", id: "1", format: :json)
    end
  end
end
