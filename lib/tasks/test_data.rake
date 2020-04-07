namespace :test_data do
  desc "Generates test data and writes to the DB"

  task generate: :environment do
    # First increasing sequence counter to prevent validation errors
    (1..User.count).each { FactoryBot.build(:user) }
    users = FactoryBot.create_list(:user, rand(5..10))

    posts = FactoryBot.create_list(:post, rand(30..60))

    (1..rand(50..100)).each do
      FactoryBot.create(:comment, post: posts.sample)
    end

    # Include the first user to make sure we generate likes from current_user
    users << User.first unless users.include?(User.first)
    (1..rand(100..200)).each do
      FactoryBot.create(:like, post: posts.sample, user: users.sample)
    rescue ActiveRecord::RecordInvalid
      # Nothing to do, just prevent job from failing
    end
  end
end
