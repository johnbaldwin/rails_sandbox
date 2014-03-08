#
# https://devcenter.heroku.com/articles/rails-unicorn
# http://unicorn.bogomips.org/Unicorn/Configurator.html
#
# Check out the pid manipulation here:
# http://joshsymonds.com/blog/2012/02/27/setting-up-unicorn-in-a-production-environment/

# This line seems to be required to keep from failing on referencing Rails
require File.dirname(__FILE__)+'/application'

# Remarking out Rails.logger here until I can figure out why it is not available
# Error: undefined method `info' for nil:NilClass

#Rails.logger.info "Unicorn in #{Rails.env} mode"


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
    if defined?(Resque) # && ENV['REDISTOGO_URL']
        Resque.redis.quit
        #Rails.logger.info('Disconnected from Redis')
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
      if ENV['REDISTOGO_URL']
        Resque.redis = ENV['REDISTOGO_URL']
      end
        Resque.redis = ENV['REDIS_URI']
        #Rails.logger.info('Connected to Redis')
    end
end

