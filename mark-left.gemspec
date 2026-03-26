# frozen_string_literal: true

require_relative 'lib/mark_left/version'

Gem::Specification.new do |spec|
  spec.name    = 'mark-left'
  spec.version = MarkLeft::VERSION
  spec.summary     = 'Convert between Markdown and Textile'
  spec.description = 'Converts Markdown syntax to Textile syntax, with configurable header levels and list depth.'
  spec.authors     = ['Gloria Budiman']
  spec.email       = ['wahyu.g@gmail.com']
  spec.homepage    = 'https://github.com/gbudiman/mark-left'

  spec.required_ruby_version = '>= 2.6'

  spec.license = 'MIT'

  spec.require_paths = ['lib']
  spec.files = Dir['lib/**/*.rb'] + ['LICENSE']

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = spec.homepage
  spec.metadata['changelog_uri']         = "#{spec.homepage}/blob/main/CHANGELOG.md"
end
