module Consul
  class Application < Rails::Application
    config.consul = config_for(:consul)
  end
end
