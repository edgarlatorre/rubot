# Public: methods to help to remove escaped characters
module StringHelper
  # Public: Split line by space, and replace escaped character
  #         word by word calling clean_line.
  # Examples
  #
  #   StingHelper.clean_line(
  #     "= I\bIn\bnt\bte\beg\bge\ber\br#\b#z\bze\ber\bro\bo?\b?"
  #   )
  #   # => '= Integer#zero?'
  def self.clean_line(line)
    return line unless line.include?(%(\b))

    new_line = ''
    line.split.each do |word|
      new_line += " #{clean_word(word)}"
    end

    new_line
  end

  # Public: Split word by \b character and replace for the right
  #         character.
  # Examples
  #
  #   StingHelper.clean_word("I\bIn\bnt\bte\beg\bge\ber\br")
  #   # => '= Integer'
  def self.clean_word(word)
    return word unless word.include?(%(\b))

    new_word = ''
    characters = word.split(%(\b))

    characters.each_with_index do |c, index|
      next if index == characters.length - 1
      new_word += get_char(c)
    end

    new_word
  end

  # Public: returns the char that was escaped.
  #
  # Examples
  #
  #   StingHelper.get_char("ae")
  #   # => 'e'
  #
  #   StingHelper.get_char("a")
  #   # => 'a'
  def self.get_char(char)
    char.length == 2 ? char[1] : char[0]
  end
end
