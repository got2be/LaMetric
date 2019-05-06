LaMetric
==============

Ruby adapter for [LaMetric](https://lametric.com/) clocks


Installation
-----------------

Add to your Gemfile:

    gem 'la_metric'

Or execute:

    gem install la_metric


Configuration
-----------------

Configure url and access token if you want to push data to your widget:

    LaMetric.configure do |config|
      config.url = 'your_app_push_url'
      config.access_token = 'your_access_token'
    end

Or via environment variables:

    LA_METRIC_URL=your_app_push_url
    LA_METRIC_ACCESS_TOKEN=your_access_token


Usage
-----------------

Add your frames:

    frames = LaMetric::Frames.new
    frames.push('Some text')
    frames.push(text: 9999, icon: 'i34', index: 0)

Push frames to widget:

    LaMetric.push(frames)

Or render frames in your controller

    render json: frames.to_json


Contribution
-----------------

Feel free :)


Author
-----------------

Ilia Kasianenko [@got2be](https://github.com/got2be)
