require 'faye/websocket'
require 'eventmachine'
require './lib/slack/rtm_api'
require './lib/slack/event_message'
require './lib/bot.rb'

socket_url = Slack::RtmApi.start
bot = nil

if socket_url.nil?
  puts 'Was not possible to connect to slack, please check your SLACK_TOKEN'
else
  EM.run do
    ws = Faye::WebSocket::Client.new(socket_url)

    ws.on :open do
      p 'Opening connection'
    end

    ws.on :message do |event|
      message = Slack::EventMessage.new(event)
      p "Message type: #{message.type} from #{message.user} message: #{message.text}"

      bot = Bot.new(message.user) if message.presence_change?
      if message.message? && message.text
        if bot.need_to_answer?(message.text)
          msg = bot.answer(message)
          ws.send(msg)
        end
      end
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end
  end
end
