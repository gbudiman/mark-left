# frozen_string_literal: true

module MarkLeft
  # Holds global defaults for all MarkLeft conversions.
  # Override these in an initializer (e.g. config/initializers/mark_left.rb):
  #
  #   MarkLeft.configure do |config|
  #     config.header_level = 'h2'   # Textile heading tag (default: 'h3')
  #     config.list_depth   = 1      # Leading asterisks for depth-1 unordered list items (default: 3)
  #   end
  #
  # Per-call options always take precedence over these defaults:
  #
  #   MarkLeft.convert(markdown, list_depth: 1)
  class Configuration
    attr_reader :header_level, :list_depth

    def initialize
      @header_level = 'h3'
      @list_depth = 3
    end

    def header_level=(value)
      MarkLeft::ToTextile::InvalidHeaderLevelError.validate!(value)
      @header_level = value
    end

    def list_depth=(value)
      MarkLeft::ToTextile::InvalidListDepthError.validate!(value)
      @list_depth = value
    end
  end
end
