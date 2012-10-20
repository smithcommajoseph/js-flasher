module JsFlasher

    module Configuration

        VALID_OPTIONS = [
            :template_dirs,
            :template_suffix
        ]

        VALID_OPTIONS.each { |opt| attr_accessor opt }

        DEFAULT_TEMPLATE_DIRS = {:Templates => 'app/assets/templates'}

        DEFAULT_TEMPLATE_SUFFIX = '.tpl.html'

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
            self.template_dirs      = DEFAULT_TEMPLATE_DIRS
            self.template_suffix    = DEFAULT_TEMPLATE_SUFFIX
        end

    end

end
