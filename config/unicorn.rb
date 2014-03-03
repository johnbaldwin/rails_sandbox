#
# https://devcenter.heroku.com/articles/rails-unicorn
# http://unicorn.bogomips.org/Unicorn/Configurator.html

Rails.logger.info "Unicorn in #{Rails.env} mode"

if Rails.env == 'development'
    worker_processes = 1
    timeout 3600
else
    worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
    timeout 25
end

preload_app true

before_fork do |server, worker|
    Signal.trap 'TERM' do
        puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
        Process.kill 'QUIT', Process.pid
    end

    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!

    # If you are using Redis but not Resque, change this
    if defined?(Resque)
        Resquew.redis.quit
        Rails.logger.info('Disconnected from Redis')
    end
end

after_fork do |server, worker|
    Signal.trap 'TERM' do
        puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
    end

    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection

    # If you are using Redis but not Resque, change this
    if defined?(Resque)
        Resque.redis = ENV['REDIS_URI']
        Rails.logger.info('Connected to Redis')
end

