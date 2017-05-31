require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review') }


  describe 'validations' do
   it "is valid with valid attributes" do
     expect(user.reviews.create(name: 'Anything')).to be_valid
    end

    it "is not valid without a name" do
      expect(user.reviews.create(name: "")).to be_valid
     end

     it 'should belong to user' do
      expect(user.id).to eq(review.user_id)
    end

  end


describe :get_review_name do
   it 'should get review name' do
     name = Review.get_review_name
     name.should_not eql("")
   end
 end

describe :save_review_and_goals do
  it 'should save the review ' do
    goals_attributes = [{"description"=>"Goal1", "weightage"=>"25"}, {"description"=>"Gola2", "weightage"=>"25"}, {"description"=>"Goal3", "weightage"=>"25"}, {"description"=>"Gol4", "weightage"=>"25"}]
    isSaved = review.save_review_and_goals(goals_attributes: goals_attributes)
    expect(isSaved).to eq(true)
  end
 end

end
