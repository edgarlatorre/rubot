require_relative '../test_helper.rb'
require './lib/slack/rtm_api.rb'
require 'webmock/minitest'

class SlackRtmApiTest < Minitest::Test
  def test_start_returns_websocket_url
    resp = "{\"url\":\"wss://slack-websocket-url\"}"
    fake_request(:post, resp)
    assert Slack::RtmApi.start == 'wss://slack-websocket-url'
  end

  def test_start_returns_nil
    resp = "{\"ok\":false,\"error\":\"invalid_form_data\"}"
    fake_request(:post, resp)
    assert Slack::RtmApi.start.nil?
  end

  private

  def fake_request(method, response)
    url = 'https://slack.com/api/rtm.start'
    stub_request(method, url).to_return(body: response)
  end
end
