#js-flasher

A simple gem that exposes unprocessed JS templates.

##Usage

Docs coming..

config like so

    //config/initializers/js_flasher.rb

    JsFlasher::configure do |c|
		c.template_sources = {:Templates => 'app/assets/templates', :Web => 'app/assets/app/web/'}
		c.supported_extensions = ['.tpl.html']
	end


##Upcoming

docs, non-Rails dependent