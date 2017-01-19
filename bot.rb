require 'json'
require 'faye/websocket'
require 'eventmachine'


response = JSON.parse(
  HTTP.post(
    'https://slack.com/api/rtm.start',
    params: {token: ENV['SLACK_TOKEN']}
  )
)

socket_url = response['url']

EM.run {
  ws = Faye::WebSocket::Client.new(socket_url)

  ws.on :open do |event|
    p [:open]
  end

  ws.on :message do |event|
    data = JSON.parse(event.data) if event && event.data
    p [:message, data]

    if data && data['type'] == 'message'
      p data
      ws.send(
        {
          type: 'message',
          text: "Hi, <@#{data['user']}>",
          channel: "#{data['channel']}"
        }.to_json
      )
    end
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}
