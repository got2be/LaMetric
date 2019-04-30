module LaMetric
  class ConfigurationMissing < StandardError
    def initialize(config_name)
      super("#{config_name} configuration is missing.")
    end
  end

  class Configuration
    attr_accessor :url, :access_token

    def initialize
      @url = ENV.fetch('LA_METRIC_URL', nil)
      @access_token = ENV.fetch('LA_METRIC_ACCESS_TOKEN', nil)
    end

    def validate!
      [:url, :access_token].each do |cfg|
        raise LaMetric::ConfigurationMissing, cfg if send(cfg).nil?
      end
    end
  end
end
