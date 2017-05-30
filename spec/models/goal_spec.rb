require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review') }
  let(:goal) { review.goals.create(description: 'test description',weightage: 33) }


  describe 'validations' do
   it "is valid with valid attributes" do
     expect(review.goals.create(description: 'test description', weightage: 33)).to be_valid
    end

    it "is not valid without a description" do
      expect(review.goals.create(description: '', weightage: 33)).to be_valid
    end

    it "is not valid without a weightage" do
      expect(review.goals.create(description: 'test description')).to be_valid
    end

  end


end
