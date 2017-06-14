class AddFeedbackUserIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :feedback_user_id, :integer
  end
end
