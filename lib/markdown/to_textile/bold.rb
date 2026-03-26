# frozen_string_literal: true

module Markdown
  class ToTextile
    # Converts Markdown bold syntax to Textile bold syntax.
    # Both ** and __ delimiters are supported.
    #
    # | Input (Markdown)          | Output (Textile)        |
    # |---------------------------|-------------------------|
    # | **hello**                 | *hello*                 |
    # | __hello__                 | *hello*                 |
    # | foo **bar** baz           | foo *bar* baz           |
    # | **a** and **b**           | *a* and *b*             |
    module Bold
      def self.execute(line)
        line.gsub(/\*\*(.+?)\*\*|__(.+?)__/) { "*#{::Regexp.last_match(1) || ::Regexp.last_match(2)}*" }
      end
    end
  end
end
