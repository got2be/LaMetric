require 'faraday'
require_relative 'la_metric/frames'
require_relative 'la_metric/configuration'

module LaMetric
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.push(frames)
    configuration.validate!

    conn = Faraday.new(url: configuration.url)
    conn.post do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Cache-Control'] = 'no-cache'
      req.headers['X-Access-Token'] = configuration.access_token
      req.body = frames.serialize
    end
  end
end
