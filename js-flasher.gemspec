$:.push File.expand_path("../lib", __FILE__)
require "js_flasher/version"

Gem::Specification.new do |s|
	s.name			= "js-flasher"
	s.version		= JsFlasher::VERSION
	s.authors		= ["Jos Smith"]
	s.email			= ["technicolorenvy@gmail.com"]
	s.homepage		= "https://github.com/technicolorenvy/js-flasher"
	s.summary		= "A simple gem that exposes unprocessed JS templates"
	s.description	= "A simple gem that exposes unprocessed JS templates"

	s.files			= `git ls-files`.split("\n")
	s.require_paths = ["lib"]
	# s.add_dependency 'railties', '>= 3.1'
	# s.add_dependency 'rails', '>= 3.1'
 
end