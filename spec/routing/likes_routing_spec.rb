describe LikesController do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/posts/1/like").
        to route_to("likes#show", post_id: "1", format: :json)
    end

    it "routes to #create" do
      expect(post: "/posts/1/like").
        to route_to("likes#create", post_id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/posts/1/like").
        to route_to("likes#destroy", post_id: "1", format: :json)
    end
  end
end
