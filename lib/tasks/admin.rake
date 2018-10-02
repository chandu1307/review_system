namespace :admin do
  desc 'give admin permissions'
  task give_admin_permissions: :environment do
    User.where(admin: true).find_each { |u| u.update(admin: false) }
    ['pradeep@beautifulcode.in', 'gj@beautifulcode.in', 'ravi@beautifulcode.in']
      .each do |email|
      User.where(email: email).update(admin: true)
    end
  end

  desc 'load_test'
  task load_test: :environment do
    users = User.all
    users.each do |user|
      20.times do |j|
        review = user.reviews.build(name: 'name' + (100 + j).to_s,
                                    mode: Review.modes['started'])
        review.save
        goal = review.build_goal
        goal.description = 'Hi'
        goal.save

        feedback = goal.feedbacks.create(user_id: 2, content: 'Feedabck')
        feedback.save
        review.mode = 'feedback_submitted'
        review.save
      end
    end
    30.times do |i|
    end
  end
end
