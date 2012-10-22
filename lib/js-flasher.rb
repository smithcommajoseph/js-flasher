# require 'js-flasher/engine'
require 'js_flasher/version'
require 'js_flasher/configuration'
require 'js_flasher/get_templates'

module JsFlasher
  extend Configuration
  extend GetTemplates
  require 'js_flasher/railtie' if defined?(Rails)
end

