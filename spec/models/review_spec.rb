require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review') }


  describe 'validations' do
   it "is valid with valid attributes" do
     expect(user.reviews.create(name: 'Anything')).to be_valid
    end

    it "is not valid without a name" do
      review = user.reviews.create(name: "")
      expect(review).not_to be_valid
      expect(review.errors.messages.keys).to include("name")
     end

     it 'should belong to user' do
      expect(user.id).to eq(review.user_id)
    end

  end


describe :get_review_name do
   it 'should get review name' do
     expect(Review.get_review_name).not_to eq("")
   end
 end

describe :save_review_and_goals do
  it 'should save the review ' do
    goals_attributes = [{"description"=>"Goal1", "weightage"=>"50"}, {"description"=>"Gola2", "weightage"=>"50"}, ]
    expect(review.save_review_and_goals(goals_attributes: goals_attributes)).to be_truthy
  end
 end

end
