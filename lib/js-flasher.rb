require 'js_flasher/version'
require 'js_flasher/configuration'
require 'js_flasher/get_templates'

module JsFlasher
  extend Configuration
  extend GetTemplates
  require 'js_flasher/railtie' if defined?(Rails)
end

class JsFlasherInstance
  # include JsFlasher
  include JsFlasher::Configuration
  include JsFlasher::GetTemplates

  def initialize(config = {})
    reset()

    config.each do |opt, val|
      self.send("#{opt}=",val)
    end
  end

end