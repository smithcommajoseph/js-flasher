# require 'js-flasher/engine'
require 'js-flasher/version'
require 'js-flasher/configuration'

module JsFlasher
    extend Configuration

    def self.get_templates

        templates = {}

        self.template_dirs.each do |tpl_name, tpl_dir|
            templates[tpl_name] = {}

            Dir.chdir(tpl_dir) do 
                outs = Dir.glob("**/*")

                outs.each do |filename|
                    if filename.include? self.template_suffix
                        filecontents = File.open(filename, "rb") { |f| f.read }
                        templates[tpl_name][filename] = filecontents.gsub(/([\n\t\r])/, '')
                    end
                end
            end

        end

        return templates

    end

end