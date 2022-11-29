class FakeJob < ApplicationJob
  queue_as :default

  def perform
    puts "Starting the fake job"
    sleep(3) # Calling an heavy API for instance
    puts "The job is done"
  end
end
