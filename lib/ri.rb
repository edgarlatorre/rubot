require './lib/string_helper.rb'

# Public: methods related to rdoc
class RI
  # Public: runs ri command to find a documentation
  # replace escape b character and returns the content.
  #
  # Examples
  #
  #   RI.find(String.eql?)
  #   # => ''
  #   = String#eql?
  #
  #   (from ruby site)
  #   ------------------------------------------------------------
  #     str.eql?(other)   -> true or false
  #
  #   ------------------------------------------------------------
  #
  # Two strings are equal if they have the same length and content.
  def self.find(param)
    output = `ri #{param}`
    replace_content(output)
  end

  # Public: Replace all lines removing escaped charaters
  #
  # Examples
  #
  #   RI.find(String.eql?)
  #   # => ''
  #   = String#eql?
  #   ...
  def self.replace_content(content)
    new_content = ''

    content.split(%(\n)).each do |line|
      new_content += "#{StringHelper.clean_line(line)}\n"
    end

    new_content
  end
end
