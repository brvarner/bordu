redis_url = Rails.application.credentials.dig(:redis, :url) || 'redis://localhost:6379/1'
Redis.current = Redis.new(url: redis_url)
