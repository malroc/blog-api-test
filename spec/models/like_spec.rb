describe Like do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to(:post).counter_cache(true) }

  describe "validators" do
    subject { build(:like) }

    it { is_expected.to validate_presence_of :post_id }
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end
end
