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
end
