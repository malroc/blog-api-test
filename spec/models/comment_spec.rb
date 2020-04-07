describe Comment do
  it { is_expected.to belong_to :post }

  it { is_expected.to validate_presence_of :post_id }
  it { is_expected.to validate_presence_of :body }

  describe "#touch_post" do
    let!(:post) { create(:post) }
    let!(:comment) { create(:comment, post: post) }

    it "updates commented_at attribute of the post" do
      expect(post.commented_at).to be_a ActiveSupport::TimeWithZone
    end
  end
end
