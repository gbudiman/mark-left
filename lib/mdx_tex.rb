# frozen_string_literal: true

require 'mdx_tex/version'
require 'mdx_tex/configuration'
require 'mdx_tex/to_textile'

module MdxTex
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
      MdxTex::ToTextile.new(**merged).execute(markdown)
    end

    def load_string_extension!
      require 'mdx_tex/core_ext/string'
    end
  end
end

require 'mdx_tex/railtie' if defined?(Rails::Railtie)
