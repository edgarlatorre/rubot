require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

class EventFake
  attr_accessor :text, :user, :channel, :type

  def initialize(text, user, channel, type)
    @text = text
    @user = user
    @channel = channel
    @type = type
  end
end
