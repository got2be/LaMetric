require 'spec_helper'
require 'securerandom'
require './lib/la_metric'
require './lib/la_metric/frames'

RSpec.describe LaMetric do
  describe 'push' do
    subject { described_class.push(frames) }

    let(:frames) do
      frames = LaMetric::Frames.new
      frames.add 'some frame'
      frames.add 'some other frame'
      frames
    end

    context 'required configuration is missing' do
      before { LaMetric.instance_variable_set(:@configuration, nil) }

      it 'raises ConfigurationMissing error' do
        expect { subject }.to raise_error(LaMetric::ConfigurationMissing)
      end
    end

    context 'configuration is ok' do
      let(:url) { FFaker::Internet.http_url }
      let(:access_token) { SecureRandom.uuid }
      let(:request_headers) do
        {
          'Accept' => 'application/json',
          'Cache-Control' => 'no-cache',
          'X-Access-Token' => access_token
        }
      end

      before do
        stub_request(:post, url).with(body: frames.serialize).to_return(status: 200)
      end

      context 'configuration is set via environment variables' do
        before do
          LaMetric.instance_variable_set(:@configuration, nil)
          ENV['LA_METRIC_URL'] = url
          ENV['LA_METRIC_ACCESS_TOKEN'] = access_token
        end

        after do
          ENV.delete 'LA_METRIC_URL'
          ENV.delete 'LA_METRIC_ACCESS_TOKEN'
        end

        it 'pushes serialized frames to LaMetric server' do
          subject
          expect(WebMock).to have_requested(:post, url).with(body: frames.serialize, headers: request_headers).once
        end
      end

      context 'configuration is set via .configure method' do
        before do
          LaMetric.instance_variable_set(:@configuration, nil)
          LaMetric.configure do |config|
            config.url = url
            config.access_token = access_token
          end
        end

        it 'pushes serialized frames to LaMetric server' do
          subject
          expect(WebMock).to have_requested(:post, url).with(body: frames.serialize, headers: request_headers).once
        end
      end
    end
  end
end
