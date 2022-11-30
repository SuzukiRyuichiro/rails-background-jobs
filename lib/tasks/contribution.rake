namespace :contribution do
  desc "Get number of contributions"
  task get: :environment do
    GetContributionsJob.perform_later
  end
end
