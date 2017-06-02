require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review') }


  #TODO Implement in similar fashion as User
  describe 'validations' do
    it "is valid with valid attributes" do
      expect(user.reviews.create(name: 'Anything')).to be_valid
    end

    it "is not valid without a name" do
      review = user.reviews.create(name: "")
      expect(review).not_to be_valid
      expect(review.errors.messages.keys).to include(:name)
    end

    it 'should belong to user' do
      expect(user.id).to eq(review.user_id)
    end
  end

  describe :get_review_name do
    context "First quarter" do
      [1, 2, 3].each do |month_number|
        it "should return Quater 1 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include("Quarter 1")
        end
      end
    end

    context "Second quarter" do
      [4, 5, 6].each do |month_number|
        it "should return Quater 1 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include("Quarter 2")
        end
      end
    end

    context "Third quarter" do
      [7, 8, 9].each do |month_number|
        it "should return Quater 1 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include("Quarter 3")
        end
      end
    end

    context "Fourth quarter" do
      [10, 11, 12].each do |month_number|
        it "should return Quater 1 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include("Quarter 4")
        end
      end
    end
  end

  describe :save_review_and_goals do
    context "Invalid Details" do

      it "should raise error if review does not have any goals"
      it "shoudl raise error if description is missing for any goal"
      #TODO IF weightage is to be dropped then ignore below
      it "should raise error if sum of wieghtages is not eual to 100"
    end

    context "Valid Details" do
      it "save review and add saved goals to it"

    end

    it 'should save the review ' do
      goals_attributes = [{"description"=>"Goal1", "weightage"=>"50"}, {"description"=>"Gola2", "weightage"=>"50"}, ]
      expect(review.save_review_and_goals(goals_attributes: goals_attributes)).to be_truthy
    end
  end
end
