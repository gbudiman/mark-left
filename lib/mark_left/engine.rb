# frozen_string_literal: true

if defined?(Rails::Engine)
  module MarkLeft
    class Engine < ::Rails::Engine
      config.autoload_paths << "#{root}/lib"
    end
  end
end
