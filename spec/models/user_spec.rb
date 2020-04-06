describe User do
  describe "validators" do
    subject { build(:user) }

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of :email }
  end

  it { is_expected.to have_many(:likes).dependent(:destroy) }
end
