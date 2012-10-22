namespace :js_flasher do
    desc ""
    task :build_files => :environment do
        templates_object    = JsFlasher::get_templates
        target_dir          = JsFlasher::target_directory
        namespace           = JsFlasher::js_namespace

        templates_object.each do |ob_name, templates|
            out = "var #{js_namespace} = #{js_namespace} || {}; "

            out << "#{js_namespace}.#{ob_name} = "
            out << "<%= JsFlasher.get_templates[ob_name].to_json %>;"

            FileUtils.mkdir_p(target_dir)

            File.open("#{target_dir}/#{ob_name}.js.erb", 'w') {|f| f.write(out) }
        end

    end
    
end