namespace :admin do
  desc 'give admin permissions'
  task give_admin_permissions: :environment do
    User.where(admin: true).find_each { |u| u.update(admin: false) }
    ['mouli@beautifulcode.in', 'gj@beautifulcode.in', 'ravi@beautifulcode.in']
      .each do |email|
      User.where(email: email).update(admin: true)
    end
  end
end
