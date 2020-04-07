class AddCommentedAtToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :commented_at, :datetime
  end
end
