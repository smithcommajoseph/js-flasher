require 'js-flasher'
require 'rails'
module JsFlasher
  class Railtie < Rails::Railtie
    railtie_name :js_flasher

    rake_tasks do
    	Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end
end