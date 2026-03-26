# frozen_string_literal: true

require 'markdown/to_textile/header'
require 'markdown/to_textile/bold'
require 'markdown/to_textile/unordered_list'
require 'markdown/to_textile/ordered_list'

module Markdown
  class ToTextile
    def initialize(header_level: 'h3')
      @header_level = header_level
    end

    def convert(input)
      input.split("\n", -1).map { |line| convert_line(line) }.join("\n")
    end

    private

    def convert_line(line)
      line = Header.execute(line, header_level: @header_level)
      line = Bold.execute(line)
      line = UnorderedList.execute(line)
      OrderedList.execute(line)
    end
  end
end
