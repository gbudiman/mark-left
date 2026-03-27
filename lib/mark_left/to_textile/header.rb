# frozen_string_literal: true

module MarkLeft
  class ToTextile
    # Converts a Markdown heading to a Textile heading.
    # The caller supplies the desired Textile header tag via +header_level+.
    # A space must follow the # characters for the line to be recognised as a heading.
    # Lines that do not match are returned unchanged.
    #
    # | Input (Markdown)   | header_level | Output (Textile) |
    # |--------------------|--------------|------------------|
    # | # Title            | h1           | h1. Title        |
    # | ## Section         | h2           | h2. Section      |
    # | ### Note           | h3           | h3. Note         |
    # | #NoSpace           | h1           | #NoSpace         |
    module Header
      def self.execute(line, header_level:)
        line.sub(/\A#+\s+(.+)\z/, "#{header_level}. \\1")
      end
    end
  end
end
