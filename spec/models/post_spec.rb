describe Post do
  it { is_expected.to validate_presence_of :body }

  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
end
