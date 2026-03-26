# frozen_string_literal: true

module Markdown
  class ToTextile
    # Converts a Markdown unordered list item to a Textile unordered list item.
    # Nesting depth is determined by leading indentation (2 spaces per level).
    #
    # | Input (Markdown)    | Output (Textile) |
    # |---------------------|------------------|
    # | - Item              | * Item           |
    # |   - Nested          | ** Nested        |
    # |     - Deep          | *** Deep         |
    module UnorderedList
      INDENT_SIZE = 2

      def self.execute(line)
        line.sub(/\A(\s*)-\s+(.+)\z/) do
          depth = (::Regexp.last_match(1).length / INDENT_SIZE) + 1
          "#{'*' * depth} #{::Regexp.last_match(2)}"
        end
      end
    end
  end
end
