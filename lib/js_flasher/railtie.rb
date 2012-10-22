require 'rails'
module JsFlasher
  class Railtie < Rails::Railtie
    rake_tasks do
    	load 'tasks/js-flasher.rake'
    end
  end
end