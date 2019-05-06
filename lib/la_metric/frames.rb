require 'json'
require_relative 'frame'

module LaMetric
  class Frames
    attr_accessor :frames

    def initialize
      @frames = []
    end

    def add(frame_data)
      @frames << LaMetric::Frame.new(normalize(frame_data))
    end

    def to_json
      { frames: frames }.to_json
    end

    private

    def normalize(frame_data)
      if frame_data.is_a? Hash
        frame_data.slice(:text, :icon, :index)
      else
        { text: frame_data }
      end
    end
  end
end
