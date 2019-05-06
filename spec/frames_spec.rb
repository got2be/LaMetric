require 'spec_helper'
require './lib/la_metric/frames'
require 'securerandom'

RSpec.describe LaMetric::Frames do
  describe '.add' do
    subject { instance.add(raw_data) }

    let(:instance) { described_class.new }

    context 'input is a hash' do
      let(:raw_data) do
        {
          text: SecureRandom.uuid,
          icon: 'icon',
          index: Random.rand(10)
        }
      end

      it 'adds new Frame to a stack' do
        expect { subject }.to change { instance.frames.length }.by(1)
        expect(instance.frames.last).to eq(LaMetric::Frame.new(raw_data))
      end
    end

    context 'input is not a hash' do
      let(:raw_data) { ['string', 123, nil, true].sample }


      it 'adds new Frame to a stack' do
        expect { subject }.to change { instance.frames.length }.by(1)
        expect(instance.frames.last).to eq(LaMetric::Frame.new(text: raw_data))
      end
    end
  end

  describe '.to_json' do
    subject { instance.to_json }

    let(:instance) { described_class.new }

    before do
      instance.add('some frame')
      instance.add('some other frame')
    end

    it 'returns serialized json' do
      expect(subject).to eq({ frames: instance.frames }.to_json)
    end
  end
end
