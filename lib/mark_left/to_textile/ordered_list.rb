# frozen_string_literal: true

module MarkLeft
  class ToTextile
    # Converts a Markdown ordered list item to a Textile ordered list item.
    # Nesting depth is determined by leading indentation (2 spaces per level).
    # Odd-numbered spaces are rounded down: 1 space is treated the same as 0 spaces.
    #
    # | Input (Markdown)    | Output (Textile) |
    # |---------------------|------------------|
    # | 1. Item             | # Item           |
    # | 99. Item            | # Item           |
    # |   1. Nested         | ## Nested        |
    # |     1. Deep         | ### Deep         |
    module OrderedList
      INDENT_SIZE = 2

      def self.execute(line)
        line.sub(/\A(\s*)\d+\.\s+(.+)\z/) do
          depth = (::Regexp.last_match(1).length / INDENT_SIZE) + 1
          "#{'#' * depth} #{::Regexp.last_match(2)}"
        end
      end
    end
  end
end
