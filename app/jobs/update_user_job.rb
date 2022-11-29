class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    puts "Updating the user with email - #{user.email}..."
    # TODO: perform a time consuming task like Clearbit's Enrichment API.
    sleep 2
    puts "Done! Updated #{user.email}"
  end
end
