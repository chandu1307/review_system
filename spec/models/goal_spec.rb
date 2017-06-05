require 'rails_helper'

RSpec.describe Goal, type: :model do
  #TODO Use FactoryGirl
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review') }
  let(:goal) { review.goals.create(description: 'test description',weightage: 33) }


  describe 'Review' do
    [:description, :weightage].each do |attribute|
      it "should be invalid if #{attribute} is missing" do
        goal = review.goals.create(description: 'test description',weightage: 33)
        goal[attribute] = ''
        goal.save

        expect(goal).not_to be_valid
        expect(goal.errors.messages.keys).to include(attribute)
      end
    end

    it "is valid with valid attributes" do

      expect( review.goals.create(description: 'test description',weightage: 33) ).to be_valid
    end


  end

end
