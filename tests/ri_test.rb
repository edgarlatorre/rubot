require_relative 'test_helper'
require './lib/ri'

class RiTest < Minitest::Test
  def setup
    @string_eql_doc = "= String#eql?\n\n(from ruby site)\n"\
      "------------------------------------------------------------------------------\n"\
      "  str.eql?(other)   -> true or false\n\n"\
      "------------------------------------------------------------------------------\n\n"\
      "Two strings are equal if they have the same length and content.\n\n\n"

    @int_zero_doc = "= Integer#zero?\n\n"\
      "(from ruby core)\n"\
      "=== Implementation from Numeric\n"\
      "------------------------------------------------------------------------------\n"\
      "  num.zero?  ->  true or false\n\n"\
      "------------------------------------------------------------------------------\n\n"\
      "Returns true if num has a zero value.\n\n\n"
  end

  def test_find_return_string_eql_returns_documentation
    text = RI.find('String#eql?')
    assert text == @string_eql_doc
  end

  def test_find_returns_empty
    text = RI.find('String#eql1?')
    assert text.empty?
  end

  # def test_find_returns_integer_zero_returns_documentation
  #   text = RI.find('Integer#zero?')
  #   assert text == @int_zero_doc
  # end

  def test_replace_header_returns_right_header
    text = RI.find('String#eql?')
    replaced = RI.replace_header('String#eql?', text)

    assert replaced == @string_eql_doc
  end
end
