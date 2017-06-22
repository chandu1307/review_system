# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@gmail.com') }
  let(:review) { user.reviews.create(name: 'test review', mode: 'started') }

  %i[name mode].each do |attribute|
    it 'should be invalid if #{attribute} is missing' do
      review = user.reviews.create(name: 'Anything', mode: 'started')
      review[attribute] = ''
      review.save

      expect(review).not_to be_valid
      expect(review.errors.messages.keys).to include(attribute)
    end
  end

  it 'is valid when provided with the following attributes - name, mode' do
    expect(user.reviews.create(name: 'Anything', mode: 'started')).to be_valid
  end

  it 'should belong to a user' do
    expect(user.id).to eq(review.user_id)
  end

  describe :review_name do
    context 'when it is First quarter' do
      [1, 2, 3].each do |month_number|
        it 'should return Quarter 1 for #{month_number} month' do
          allow(Time).to receive(:now).and_return Time.zone.now.change(month:
            month_number)

          expect(Review.review_name).to include('Quarter 1')
        end
      end
    end

    context 'when it is Second quarter' do
      [4, 5, 6].each do |month_number|
        it 'should return Quater 2 for #{month_number} month' do
          allow(Time).to receive(:now).and_return Time.zone.now.change(month:
            month_number)

          expect(Review.review_name).to include('Quarter 2')
        end
      end
    end

    context 'when it is Third quarter' do
      [7, 8, 9].each do |month_number|
        it 'should return Quater 3 for #{month_number} month' do
          allow(Time).to receive(:now).and_return Time.zone.now.change(month:
            month_number)

          expect(Review.review_name).to include('Quarter 3')
        end
      end
    end

    context 'when it is Fourth quarter' do
      [10, 11, 12].each do |month_number|
        it 'should return Quater 4 for #{month_number} month' do
          allow(Time).to receive(:now).and_return Time.zone.now.change(month:
            month_number)

          expect(Review.review_name).to include('Quarter 4')
        end
      end
    end
  end

  describe :can_user_access_review do
    it 'should return true if review belongs to user' do
      expect(review.can_user_access_review?(user.id)).to eq(true)
    end

    it 'should return true if user is admin' do
      admin_user = User.create(name: 'admin', email: 'admin@gmail.com', admin:
      true)

      expect(review.can_user_access_review?(admin_user.id)).to eq(true)
    end

    it 'should return true if user is manager of review user' do
      manager_user = User.create(name: 'manager', email: 'manager@gmail.com')
      user.manager_id = manager_user.id
      user.save

      expect(review.can_user_access_review?(manager_user.id)).to eq(true)
    end

    it 'should return false if user is not an admin or manager or owner of the
    review' do
      heacker_user = User.create(name: 'heacker', email: 'heacker@gmail.com')

      expect(review.can_user_access_review?(heacker_user.id)).to eq(false)
    end
  end

  describe :manager_or_admin_for_this_review do
    it 'should return true if user is admin' do
      admin_user = User.create(name: 'admin', email: 'admin@gmail.com', admin:
      true)

      expect(review.manager_or_admin_for_this_review?(admin_user.id))
        .to eq(true)
    end

    it 'should return true if user is manager of review user' do
      manager_user = User.create(name: 'manager', email: 'manager@gmail.com')
      user.manager_id = manager_user.id
      user.save

      expect(review.manager_or_admin_for_this_review?(manager_user.id))
        .to eq(true)
    end

    it 'should return false if user is not an admin or manager' do
      heacker_user = User.create(name: 'heacker', email: 'heacker@gmail.com')

      expect(review.manager_or_admin_for_this_review?(heacker_user.id))
        .to eq(false)
    end
  end
end
