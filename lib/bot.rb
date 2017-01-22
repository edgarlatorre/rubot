require './lib/ri.rb'

# Public: Class with methods related to bot behaviour
class Bot
  attr_accessor :id
  def initialize(id)
    @id = id
  end

  # Public: check if bot needs to answer the message
  #
  # Examples
  #
  #   bot.need_to_answer?('This is a message')
  #   # => false
  #
  # Returns if bot need or not to answer
  def need_to_answer?(message)
    return true if message.include?(id)
    index = message.index('#').to_i
    index > 2 && message[index - 1] != ' ' && message[index + 1] != ' '
  end

  # Public: check how to get the data to search using ri
  # and return a message.
  #
  # Examples
  #
  #   bot.answer(message)
  #   # => 'Hi <@U1>, how can I help you?'
  #
  # Returns if bot need or not to answer
  def answer(message)
    if message.text.start_with?("<@#{id}> please explain")
      word = message.text.split("<@#{id}> please explain")[1]
      msg = format(RI.find(word))
    elsif message.text.start_with?("<@#{id}>")
      words = message.text.split
      msg = if words.length > 1
              format(RI.find(words[1]))
            else
              "Hi <@#{message.user}>, how can I help you?"
            end
    elsif message.text.include?('#')
      msg = format(RI.find(message.text))
    end

    msg = "Sorry I couldn't find it." if msg.nil?

    mount_message(msg, message.channel)
  end

  private

  def format(msg)
    "```#{msg}```"
  end

  def mount_message(message, channel)
    {
      type: 'message',
      text: message,
      channel: channel
    }.to_json
  end
end
