# frozen_string_literal: true

module MarkLeft
  class ToTextile
    # Converts a Markdown unordered list item to a Textile unordered list item.
    # Nesting depth is determined by leading indentation (2 spaces per level),
    # offset by +list_depth+ (default: 3).
    # Odd-numbered spaces are rounded down: 1 space is treated the same as 0 spaces.
    #
    # | Input (Markdown)    | list_depth | Output (Textile) |
    # |---------------------|------------|------------------|
    # | - Item              | 3          | *** Item         |
    # |   - Nested          | 3          | **** Nested      |
    # | - Item              | 1          | * Item           |
    # |   - Nested          | 1          | ** Nested        |
    module UnorderedList
      INDENT_SIZE = 2

      def self.execute(line, list_depth: 3)
        line.sub(/\A(\s*)-\s+(.+)\z/) do
          depth = (::Regexp.last_match(1).length / INDENT_SIZE) + list_depth
          "#{'*' * depth} #{::Regexp.last_match(2)}"
        end
      end
    end
  end
end
