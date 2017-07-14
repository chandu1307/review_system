require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@beautifulcode.in') }
  let(:review) { user.reviews.create(name: 'test review', mode: 'started') }
  let(:goal) { review.build_goal(description: 'test description') }
  let(:feedback) { goal.feedbacks.create(content: 'feedback') }

  [:content, :user_id].each do |attribute|
    it 'should be invalid if #{attribute} is missing' do
      goal.save
      feedback = goal.feedbacks.create(content: 'feedback', user_id: user.id)
      feedback[attribute] = ''
      feedback.save

      expect(feedback).not_to be_valid
    end
  end

  it 'is valid with provided with the following attributes - content,user_id' do
    goal.save
    expect(goal.feedbacks.create(content: 'feedback', user_id: user.id)).to be_valid
  end
end
