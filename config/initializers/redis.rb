$redis = Redis.new

url = ENV.fetch("REDISCLOUD_URL", nil)

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: }
  end
  $redis = Redis.new(url:)
end
