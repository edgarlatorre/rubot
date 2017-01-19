require 'net/http'
require 'json'

module Slack
  class RtmApi
    # Public: Starts a websocket connection with slack
    #
    # Examples
    #
    #   Slack::RtmApi.start
    #   # => 'wss://slack-websocket-url'
    #
    # Returns a url to connect to slack websocket.
    def self.start
      uri = URI('https://slack.com/api/rtm.start')
      body = JSON.parse(
        Net::HTTP.post_form(uri, token: ENV['SLACK_TOKEN']).body
      )

      body['url']
    end
  end
end
