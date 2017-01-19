# Public: Class to encapsulate event data from slack websocket.
#
# Examples
#
#   Slack#EventMessage.new(event)
#   # => <Slack::EventMessage>

require 'json'

module Slack
  class EventMessage
    attr_accessor :channel, :type, :user, :text
    def initialize(event)
      unless event.nil?
        @data = JSON.parse(event.data) if event.data

        @channel = @data['channel']
        @type = @data['type']
        @text = @data['text']
        @user = @data['user']
      end
    end

    def message?
      type == 'message'
    end

    def presence_change?
      type == 'presence_change'
    end
  end
end
