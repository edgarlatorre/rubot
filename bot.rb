require 'faye/websocket'
require 'eventmachine'
require './lib/slack/rtm_api'
require './lib/slack/event_message'

socket_url = Slack::RtmApi.start
bot_id = nil

EM.run do
  ws = Faye::WebSocket::Client.new(socket_url)

  ws.on :open do
    p 'Opening connection'
  end

  ws.on :message do |event|
    message = Slack::EventMessage.new(event)
    p "Message type: #{message.type} from #{message.user}"

    bot_id = message.user if message.presence_change?

    if message.message?
      ws.send(
        {
          type: 'message',
          text: "Hi <@#{message.user}>, I am <@#{bot_id}>",
          channel: message.channel
        }.to_json
      )
    end
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
end
