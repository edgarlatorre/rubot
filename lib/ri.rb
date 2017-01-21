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
    replace_header(param, output)
  end

  # Public: Replace first line removing escaped charaters
  #
  # Examples
  #
  #   RI.find(String.eql?)
  #   # => ''
  #   = String#eql?
  #   ...
  def self.replace_header(param, content)
    header = content.split(%(\n\n)).first.to_s
    header.empty? ? content : content.gsub(header, "= #{param}")
  end
end
