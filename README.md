js-flasher
==========

A simple gem that exposes unprocessed JS templates.

`js-flasher`, as the name loosely suggests, exposes something. At its core, it will take files, and build Javascript objects keyed by filename, where the contents of the file are the values. It can run happily alongside, but is not dependent on, Sprockets.

###### Why would I use this over other solutions like Sprockets JST templates?

Since `js-flasher` passes around an object packed with your markup, rather than template functions, you are free to pass many templates, without fear that you generating large objects of precompiled template functions. This approach has bonuses as well as drawbacks.

Bonuses

- less data is being passed around than say, Sprockets' templates, therefore actual JS payload can be much smaller
- you are given full flexiblity to handle rendering your templates however you see fit

Drawbacks

- more client-side processing as you compile/render your templates at runtime or JS app bootstrap.

If you have read the above and feel like `js-flasher` is a good fit for your project, continue on.


## Installation:

If you're using Bundler, this will get you up and running 

    gem 'js-flasher', :git => 'git://github.com/technicolorenvy/js-flasher.git'


or, for non-Bundler-users 

    git clone git://github.com/technicolorenvy/js-flasher.git 
    cd js-flasher
    gem build js-flasher.gemspec
    gem install js-flasher-VERSION.gem

NOTE: The only dependency this gem has is the `json` gem, which is likely already installed for most users

### Default Config

`js-flasher` ships with some (hopefully) smart defaults. These are largely geared towards a vanilla Rails 3.1 (or higher) environment, but are easily be overridden.

##### Template Sources

Hash of template sources arranged as 'Target Object' => 'Source Directory'

    :template_sources = {:Templates => 'app/assets/templates'}


##### Supported Extensions

Array of file endings

    :supported_extensions = ['.tpl.html']

##### Target Directory

String representation of your target directory

    :target_directory = 'app/assets/javascripts/templates'

##### JS Namespace

Parent Javascript object generated for namespacing

    :js_namespace = 'JSF'

##### Extensions in Keys

Shoud the resulting JS object include file extensions in it's keys?

    :extensions_in_keys = false

## Usage - Rails:

#### Config

The recommended process for modifying `js-flasher` configuration in Rails is

- Add an initializer to `conf/initializers/` named `js-flasher.rb`
- Apply configuration changes via a do block 

		JsFlasher::configure do |c|
			c.template_sources = {:Shared => 'app/assets/templates', :Web => 'app/assets/app/web/'}
			c.supported_extensions = ['.my.extension1', '.extension2', '.etc']
		end


#### Create files

You can create files for your JS template objects by running `rake js_flasher:build_files`. This will create a file for each template source that you have passed in.

For example, given the above configure block, we would create two files in our `app/assets/javascripts/templates` directory (our default target directory). `Shared.js.erb` and `Web.js.erb`. Each file will have only its set of templates.

The contents of the generated `Shared.js.erb` would look something like the following.

    var JSF = JSF || {}; JSF.Shared = <%= JsFlasher.get_templates([:Shared]) %>;

In this case our namespace `JSF` is also generated from our default config and may be overridden


#### Access your templates

Now in your Javascript files you are free to use whatever templating system you want. You may access your template like so.

    JSF.Shared['path/to/my/template']

Paths are relative to your template set. In other words, in the above example your template would actually live in `app/assets/templates/path/to/my/template`.

## Usage - Non Rails 
(or for those who prefer greater flexibility):

`js-flasher` comes with an instantiatable class called `JsFlasherInitable`.

#### Create + Config

- Instantiate your object, passing in your config 

        js_flasher = JsFlasherInitable.new({
            :template_sources => {
                :Shared => 'app/assets/templates', 
                :Web => 'app/assets/app/web/'
            }
        })


#### Expose templates

It's recommended that you do this through a `.js.erb` file. This way, in production, you can take advantage of cacheing, assuming you are precompiling your assets. Something like `templates.js.erb` seems nice and self-documenting.

Assuming you want All of your templates, you could create a file whose contents look like.

    # contents of templates.js.erb
    <% js_flasher = JsFlasherInitable.new({
            :template_sources => {
                :Shared => 'app/assets/templates', 
                :Web => 'app/assets/app/web/'
            }
        })
    %>
    window.Shared = <%= js_flasher.get_templates %>;

If you have multiple template sets and you prefer breaking the generated template strings into multiple files you could split them like so

shared.js.erb

    # contents of shared.js.erb
    <% shared_emplates = JsFlasherInitable.new({
            :template_sources => {
                :Shared => 'app/assets/templates', 
            }
        })
    %>
    window.Shared = <%= shared_templates.get_templates %>;

web.js.erb

    # contents of web.js.erb
    <% web_templates = JsFlasherInitable.new({
            :template_sources => {
                :Web => 'app/assets/app/web/'
            }
        })
    %>
    window.webTemplates = <%= web_templates.get_templates %>;

Using the above described methods, you can skip using `js-flasher`s `:target_directory` and `:js_namespace` options as they are mostly used for file generation in the included Rails specific Rake task.



