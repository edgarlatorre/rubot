require_relative 'test_helper'
require './lib/bot.rb'

class BotTest < Minitest::Test
  def setup
    @bot = Bot.new('UID')
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
end
