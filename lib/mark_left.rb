# frozen_string_literal: true

require 'mark_left/version'
require 'markdown/to_textile'

module MarkLeft
  def self.convert(markdown, **options)
    Markdown::ToTextile.new(**options).convert(markdown)
  end
end
