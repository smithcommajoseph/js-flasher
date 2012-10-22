namespace :js_flasher do
    desc ""
    task :build_files => :environment do
        templates_object    = JsFlasher::get_templates
        target_directory    = JsFlasher::target_directory
        js_namespace        = JsFlasher::js_namespace

        templates_object.each do |ob_name, templates|
            out = "var #{js_namespace} = #{js_namespace} || {}; "

            out << "#{js_namespace}.#{ob_name} = "
            out << "<%= JsFlasher.get_templates[:#{ob_name}].to_json %>;"

            FileUtils.mkdir_p(target_directory)

            File.open("#{target_directory}/#{ob_name}.js.erb", 'w') {|f| f.write(out) }
        end

    end
    
end