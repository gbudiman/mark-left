# frozen_string_literal: true

module MdxTex
  class Railtie < Rails::Railtie
    config.after_initialize do
      MdxTex.load_string_extension! if MdxTex.configuration.enable_string_extension
    end
  end
end
