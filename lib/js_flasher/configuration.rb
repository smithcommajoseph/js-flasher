module JsFlasher

    module Configuration

        VALID_OPTIONS = [
            :template_sources,
            :supported_extensions,
            :target_directory,
            :js_namespace
        ]

        VALID_OPTIONS.each { |opt| attr_accessor opt }

        DEFAULT_TEMPLATE_SOURCES = {:Templates => 'app/assets/templates'}

        DEFAULT_SUPPORTED_EXENSIONS = ['.tpl.html']

        DEFAULT_TARGET_DIRECTORY = 'app/assets/javascripts/templates'

        JS_NAMESPACE = 'JSF'

        # When this module is extended, set all configuration options to their default values
        def self.extended(base)
            base.reset
        end

        # Convenience method to allow configuration options to be set in a block
        def configure
            yield self
        end

        # assign our defaults
        def reset
            self.template_sources       = DEFAULT_TEMPLATE_SOURCES
            self.supported_extensions   = DEFAULT_SUPPORTED_EXENSIONS
            self.target_directory       = DEFAULT_TARGET_DIRECTORY
            self.js_namespace           = JS_NAMESPACE
        end

    end

end
