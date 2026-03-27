# frozen_string_literal: true

module MarkLeft
  class ToTextile
    # Converts Markdown bold syntax to Textile bold syntax.
    # Both ** and __ delimiters are supported and processed independently.
    # Note: nested mixed delimiters (e.g. __**text**__) are not supported.
    #
    # | Input (Markdown)          | Output (Textile)        |
    # |---------------------------|-------------------------|
    # | **hello**                 | *hello*                 |
    # | __hello__                 | *hello*                 |
    # | foo **bar** baz           | foo *bar* baz           |
    # | **a** and **b**           | *a* and *b*             |
    # | **a** and __b__           | *a* and *b*             |
    module Bold
      def self.execute(line)
        line
          .gsub(/\*\*(.+?)\*\*/, '*\1*')
          .gsub(/__(.+?)__/, '*\1*')
      end
    end
  end
end
