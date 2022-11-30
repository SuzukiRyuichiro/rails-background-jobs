namespace :user do
  desc "Update all users"
  task update_all: :environment do
    users = User.all
    puts "Enqueuing update of #{users.size} users..."
    users.each do |user|
      UpdateUserJob.perform_later(user)
    end
  end

  desc "Update a user"
  task :update, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    UpdateUserJob.perform_later(user)
  end
end
