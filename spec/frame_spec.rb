require 'spec_helper'
require './lib/la_metric/frame'

RSpec.describe LaMetric::Frame do
  describe '.members' do
    subject { described_class.new.members }
    it { is_expected.to eq([:text, :icon, :index]) }
  end
end
