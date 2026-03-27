# frozen_string_literal: true

require 'mark_left/to_textile/header'
require 'mark_left/to_textile/bold'
require 'mark_left/to_textile/unordered_list'
require 'mark_left/to_textile/ordered_list'

module MarkLeft
  class ToTextile
    VALID_HEADER_LEVELS = %w[h1 h2 h3 h4 h5 h6].freeze

    class InvalidListDepthError < ArgumentError
      def initialize(value)
        super("list_depth must be a positive integer, got: #{value.inspect}")
      end

      def self.validate!(value)
        raise self, value unless value.is_a?(Integer) && value.positive?
      end
    end

    class InvalidHeaderLevelError < ArgumentError
      def initialize(value)
        super("header_level must be one of #{VALID_HEADER_LEVELS.join(', ')}, got: #{value.inspect}")
      end

      def self.validate!(value)
        raise self, value unless VALID_HEADER_LEVELS.include?(value)
      end
    end

    def initialize(header_level: 'h3', list_depth: 3)
      InvalidHeaderLevelError.validate!(header_level)
      InvalidListDepthError.validate!(list_depth)

      @header_level = header_level
      @list_depth = list_depth
    end

    def convert(input)
      return '' if input.nil?

      input.to_s.split("\n", -1).map { |line| convert_line(line) }.join("\n")
    end

    private

    def convert_line(line)
      line = Header.execute(line, header_level: @header_level)
      line = Bold.execute(line)
      line = UnorderedList.execute(line, list_depth: @list_depth)
      OrderedList.execute(line)
    end
  end
end
