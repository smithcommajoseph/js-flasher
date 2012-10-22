js-flasher
==========

A simple gem that exposes unprocessed JS templates.

js-flasher, as the name loosely suggests, exposes something. At its core, it will take files, and build Javascript objects keyed by filename, where the contents of the file are the values.

This means you are free to pass many pieces of markup, without the worry of generating large objects of precompiled templates.



## Installation:

If you're using Bundler, this will get you up and running 

    gem 'js-flasher', :git => 'git://github.com/technicolorenvy/js-flasher.git'


or, for non-Bundler-users 

    git clone git://github.com/technicolorenvy/js-flasher.git 
    cd js-flasher
    gem build js-flasher.gemspec
    gem install js-flasher-VERSION.gem

NOTE: The only dependency this gem has is the json gem, which is likely already installed for most users

### Default Config

js-flasher ships with some (hopefully) smart defaults. These are largely geared towards a vanilla Rails 3.1 (or higher) environment, but are easily be overridden.

    :template_sources = {:Templates => 'app/assets/templates'}
    :supported_extensions = ['.tpl.html']
    :target_directory = 'app/assets/javascripts/templates'
    :js_namespace = 'JSF'

## Usage - Rails:

#### Config

The recommended process for modifying js-flasher configuration in Rails is

- Add an initializer to `conf/initializers/` named `js-flasher.rb`
- Apply configuration changes via a do block 

		JsFlasher::configure do |c|
			c.template_sources = {:Templates => 'app/assets/templates', :Web => 'app/assets/app/web/'}
			c.supported_extensions = ['.my.extension1', '.extension2', '.etc']
		end


#### Create files

You can create files for your JS template objects by running `rake js_flasher:build_files`. This will create a file for each template source that you have passed in.

For example, given the above configure block, we would create two files in our `app/assets/javascripts/templates` directory (our default target directory). `Templates.js.erb` and `Web.js.erb`. Each file will have only its set of templates.

The contents of the generated `Templates.js.erb` would look something like the following.

    var JSF = JSF || {}; JSF.Templates = <%= JsFlasher.get_templates([:Templates]) %>;

In this case our namespace `JSF` is also generated from our default config and may be overridden


#### Access your templates

Now you are free to use whatever templating language you want. You may access your glorified string, um, template like so

    JSF.Templates['path/to/my/template.tpl.html']


## Usage - Non Rails:

...coming...

