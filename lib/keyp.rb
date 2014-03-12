# Load per instance configuration data that are not in environment variables
module Keyp


  # Technically, we don't need to pass the environment because we can get it from Rails
  # Rails.env value
  # But looking are
  def self.load_app_config(env)
    config = {}
    case env

      when 'production'
        # Add any production specific configs

      when 'development'
        app_config_file = ENV['SANDBOX42_APP_CONFIG_FILE']
        unless app_config_file.nil?
          if File.exist?(app_config_file)
            config = YAML.load_file(app_config_file)
          end
        end
        config['GRUE'] ||= ENV['GRUE']

      when 'testing'
        # Add any production specific configs

      else
        raise "Unknown environment #{env}"
      end
      config
  end
end
