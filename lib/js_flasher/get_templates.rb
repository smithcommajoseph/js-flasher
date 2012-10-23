require 'json'

module JsFlasher
  module GetTemplates

    def get_templates_ob(subset = nil)

      subset ||= self.template_sources.keys
      templates_ob   = {}

      self.template_sources.each do |tpl_name, tpl_dir|

        if subset && subset.include?(tpl_name)
          templates_ob[tpl_name] = {}

          Dir.chdir(tpl_dir) do 
            outs = Dir.glob("**/*")

            outs.each do |file|
              out_arr = file.split('/').last.split('.')
              file_name = out_arr.shift
              extension = ".#{out_arr.join('.')}"
              filename_key = (self.extensions_in_keys) ? file : file_name

              if self.supported_extensions.include? extension
                filecontents = File.open(file, "rb") { |f| f.read }
                templates_ob[tpl_name][filename_key] = filecontents.gsub(/([\n\t\r])/, '')
              end
            end
          end

        end
      end

      if subset.length === 1
        templates_ob = templates_ob[subset[0].to_sym]
      end

      return templates_ob
    end

    def get_templates(subset = nil)
      templates = get_templates_ob(subset).to_json
    end

  end
end
