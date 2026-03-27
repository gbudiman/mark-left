# frozen_string_literal: true

module MdxTex
  # Holds global defaults for all MdxTex conversions.
  # Override these in an initializer (e.g. config/initializers/mdx_tex.rb):
  #
  #   MdxTex.configure do |config|
  #     config.header_level = 'h2'   # Textile heading tag (default: 'h3')
  #     config.list_depth   = 1      # Leading asterisks for depth-1 unordered list items (default: 3)
  #   end
  #
  # Per-call options always take precedence over these defaults:
  #
  #   MdxTex.to_textile(markdown: markdown, list_depth: 1)
  class Configuration
    attr_reader :header_level, :list_depth
    attr_accessor :enable_string_extension

    def initialize
      @header_level = 'h3'
      @list_depth = 3
      @enable_string_extension = false
    end

    def header_level=(value)
      MdxTex::ToTextile::InvalidHeaderLevelError.validate!(value)
      @header_level = value
    end

    def list_depth=(value)
      MdxTex::ToTextile::InvalidListDepthError.validate!(value)
      @list_depth = value
    end
  end
end
