require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review', mode: 'started') }

  [:name, :mode].each do |attribute|
    it "should be invalid if #{attribute} is missing" do
      review = user.reviews.create(name: 'Anything', mode: 'started')
      review[attribute] = ''
      review.save

      expect(review).not_to be_valid
      expect(review.errors.messages.keys).to include(attribute)
    end
  end

  it "is valid when provided with the following attributes - name, mode" do
    expect(user.reviews.create(name: 'Anything', mode: 'started')).to be_valid
  end


  it 'should belong to a user' do
    expect(user.id).to eq(review.user_id)
  end

  describe :get_review_name do
    context "when it is First quarter" do
      [1, 2, 3].each do |month_number|
        it "should return Quarter 1 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include('Quarter 1')
        end
      end
    end

    context "when it is Second quarter" do
      [4, 5, 6].each do |month_number|
        it "should return Quater 2 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include('Quarter 2')
        end
      end
    end

    context "when it is Third quarter" do
      [7, 8, 9].each do |month_number|
        it "should return Quater 3 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include('Quarter 3')
        end
      end
    end

    context "when it is Fourth quarter" do
      [10, 11, 12].each do |month_number|
        it "should return Quater 4 for #{month_number} month" do
          allow(Time).to receive(:now).and_return Time.now.change(month: month_number)

          expect(Review.get_review_name).to include('Quarter 4')
        end
      end
    end
  end
end
