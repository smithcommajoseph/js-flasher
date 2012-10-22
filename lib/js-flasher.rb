# require 'js-flasher/engine'
require 'js_flasher/version'
require 'js_flasher/configuration'

module JsFlasher
  extend Configuration

  require 'js_flasher/railtie' if defined?(Rails)

  def self.get_templates(subset = nil)

    subset ||= self.template_sources.keys
    templates   = {}

    self.template_sources.each do |tpl_name, tpl_dir|

      if subset && subset.include?(tpl_name)
        templates[tpl_name] = {}

        Dir.chdir(tpl_dir) do 
          outs = Dir.glob("**/*")

          outs.each do |filename|
            out_arr = filename.split('/').last.split('.')
            out_arr.shift
            extension = ".#{out_arr.join('.')}"

            if self.supported_extensions.include? extension
              filecontents = File.open(filename, "rb") { |f| f.read }
              templates[tpl_name][filename] = filecontents.gsub(/([\n\t\r])/, '')
            end
          end
        end

      end
    end

    return templates

  end

end

