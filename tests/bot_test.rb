require_relative 'test_helper'
require './lib/bot.rb'

class BotTest < Minitest::Test
  def setup
    @bot = Bot.new('UID')
    @event = EventFake.new('test message', 'UID', 'c', 'message')
  end

  def test_set_bot_id
    assert @bot.id == 'UID'
  end

  def test_answer_returns_false
    assert @bot.need_to_answer?('Some message') == false
  end

  def test_bot_mentioned_answer_returns_true
    assert @bot.need_to_answer?("<@#{@bot.id}>")
  end

  def test_bot_message_with_hash_answer_returns_true
    assert @bot.need_to_answer?('String#eql?')
  end

  def test_bot_message_with_hash_answer_returns_false
    assert @bot.need_to_answer?('Hi #testing') == false
  end

  def test_bot_mentioned_returns_doc_in_a_message
    @event.text = "<@#{@event.user}> String#eql?"

    assert @bot.answer(@event).include?('= String#eql?')
  end

  def test_bot_mentioned_ask_if_user_needs_help
    @event.text = "<@#{@event.user}>"
    message = @bot.answer(@event)

    assert message.include?('how can I help you?')
  end

  def test_bot_not_mentioned_returns_doc_in_a_message
    @event.text = 'Integer#zero?'
    message = @bot.answer(@event)

    assert message.include?(@event.text)
  end

  def test_bot_asked_to_explain_returns_doc_in_a_message
    @event.text = "<@#{@event.user}> please explain String"
    message = @bot.answer(@event)

    assert message.include?('=  String')
  end

  def test_bot_asked_to_explain_returns_doc_in_a_message
    @event.text = "Bla"
    message = @bot.answer(@event)

    assert message.include?("Sorry I couldn't find it.")
  end
end
