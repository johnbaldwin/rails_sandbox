# add require
Resque.redis = ENV["REDISTOGO_URL"] if ENV["REDISTOGO_URL"]
