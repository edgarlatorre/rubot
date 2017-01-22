require_relative 'test_helper.rb'
require './lib/string_helper.rb'

class StringHelperTest < Minitest::Test
  def test_clean_word_returns_orignal_word
    assert StringHelper.clean_word('String') == 'String'
  end

  def test_clean_word_returns_replaced_word
    assert StringHelper.clean_word("I\bIn\bnt\bte\beg\bge\ber\br") == 'Integer'
  end

  def test_clean_line_returns_original_line
    line = ' num.zero?  ->  true or false'
    assert StringHelper.clean_line(line) == line
  end

  def test_clean_line_returns_replaced_line
    line = "= I\bIn\bnt\bte\beg\bge\ber\br#\b#z\bze\ber\bro\bo?\b?"
    assert StringHelper.clean_line(line) == ' = Integer#zero?'
  end
end
