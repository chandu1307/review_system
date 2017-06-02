require 'rails_helper'

RSpec.describe Goal, type: :model do
  #TODO Use FactoryGirl
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review') }
  let(:goal) { review.goals.create(description: 'test description',weightage: 33) }


  #TODO Write specs in similar fashion as UserSpec
  describe 'validations' do
   it "is valid with valid attributes" do

     expect(review.goals.create(description: 'test description', weightage: 33)).to be_valid
    end

    it "is not valid without a description" do
      goal = review.goals.create(description: '', weightage: 33)

      expect(goal).not_to be_valid
      expect(goal.errors.messages.keys).to include("description")
    end

    it "is not valid without a weightage" do
      goal = review.goals.create(description: 'test description')

      expect(goal).not_to be_valid
      expect(goal.errors.messages.keys).to include("weightage")
    end
  end
end
