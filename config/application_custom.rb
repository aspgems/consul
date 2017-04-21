require 'csv'

module Consul
  class Application < Rails::Application
    config.consul = config_for(:consul)
    config.action_mailer.smtp_settings = config.consul['smtp'].symbolize_keys if config.consul.key?('smtp')
  end
end
