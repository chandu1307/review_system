
## About

Review employees performance

## How to run the app locally?
Install the right ruby version - 2.2.3 (ruby) with rvm

* `rvm install 2.2.3`
* `gem install bundler` to install the bundler gem.
* `bundle install` to install the gems for the project.
* `bundle exec rake db:create` to create the local database
* `bundle exec rake db:migrate` to migrate
* `bundle exec rails s` to start the server on port 3000


## Test Steps

* TODO
- Capture Quarter in the Review form and allow the user to create multiple reviews.
- After enterining goals, if there are errors the user should see the form with the errors at the top.
- Edit Review is showing errors.
- Add/Remove goals from a review.
- Understand the nested resource concept - http://guides.rubyonrails.org/routing.html
- Move to HAML

Refactor
Review
  #save_review_and_goals (goal_attribtues_hash)

Class method
build_goals_from_hash (goal_attributes_hash)
[Goal1, Goal2]

Review
  #save_with_goals goals:[Goal ob 1, Goal ob 2…]


Class method
build_goals_from_hash (goal_attributes_hash)
[Goal1, Goal2]

Review
  #save_with_goals goals:[Goal ob 1, Goal ob 2…]

def collect_errors goals
# Error if there are zero goals
self.errors.add(:base, “THere are no goals”) if goals.blank?

# Check if all the goals are valid. If they are invalid populate errors
goals.each_with_index do |goal, index|
  self.errors.add(:base, “Please fix the following errors for Goal #{index+1} - #{goal.errors.join(‘,’)}” if goal.invalid?
end

# Check if the review is valid.
review.valid?
end

def save_with_goals goals

# Collect all the errors
collect_errors goals

# If there are any errors return false
return false if self.errors.present?

review.goals = goals
review.save
end




Reviews Controller

create
    @review = current_user.reviews.build(name: Review.get_review_name, mode: get_review_mode)
    goal_attributes = ...
    goals = Review.build_goals(goal_attributes)

    if review.save_with_goals goals
      flash[:success] = ''
      redirect_to reviews_path
    else
      # We want to show the form with the error message so that the user can fix them.
      render 'form', object: review
    end
end


form.haml.html

- if @review.errors.present?
  - @review.errors.each do |error|
    %p= error.message

form










