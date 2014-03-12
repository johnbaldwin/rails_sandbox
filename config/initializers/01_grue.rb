#
# http://guides.rubyonrails.org/configuring.html#using-initializer-files
# Grue should be the first initializer

puts "Grue is initialized"

ENV['GRUE']='Hungry'

Dir[Rails.root + 'lib/**/*.rb'].each do |file|
  puts "requiring #{file}"
  require file
end

APP_CONFIG = Keyp::load_app_config Rails.env