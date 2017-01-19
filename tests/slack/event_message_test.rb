require_relative '../test_helper.rb'
require './lib/slack/event_message.rb'

class Event
  attr_accessor :data
  def initialize(data)
    @data = data
  end
end

class SlackEventMessageTest < Minitest::Test
  def test_event_nil_returns_attributes_nil
    event = Slack::EventMessage.new(nil)

    assert event.channel.nil?
    assert event.type.nil?
    assert event.text.nil?
    assert event.user.nil?
  end

  def test_event_sets_attribtues
    event = get_event

    assert event.channel == 'C1'
    assert event.type == 'message'
    assert event.text == 'hi'
    assert event.user == 'U1'
  end

  def test_event_is_message_returns_true
    event = get_event

    assert event.message?
  end

  def test_event_is_presence_change_returns_true
    event = get_event
    event.type = 'presence_change'

    assert event.presence_change?
  end

  private

  def get_event
    e = Event.new(get_message)
    Slack::EventMessage.new(e)
  end

  def get_message
    "{\"type\":\"message\",\"channel\":\"C1\",\"user\":\"U1\",\"text\":\"hi\"}"
  end
end
