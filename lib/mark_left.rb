# frozen_string_literal: true

require 'mark_left/version'
require 'mark_left/configuration'
require 'mark_left/engine' if defined?(Rails)
require 'markdown/to_textile'

module MarkLeft
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def to_textile(markdown:, **options)
      merged = { header_level: configuration.header_level, list_depth: configuration.list_depth }.merge(options)
      Markdown::ToTextile.new(**merged).convert(markdown)
    end
  end
end
