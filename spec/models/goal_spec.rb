# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review', mode: 'started') }
  let(:goal) { review.goals.create(description: 'test description') }

  [:description].each do |attribute|
    it 'should be invalid if #{attribute} is missing' do
      goal = review.build_goal(description: 'test description')
      goal[attribute] = ''
      goal.save

      expect(goal).not_to be_valid
      expect(goal.errors.messages.keys).to include(attribute)
    end
  end

  it 'is valid with provided with the following attributes - description' do
    expect(review.build_goal(description: 'test description')).to be_valid
  end
end
