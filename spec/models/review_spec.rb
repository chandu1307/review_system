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

end
