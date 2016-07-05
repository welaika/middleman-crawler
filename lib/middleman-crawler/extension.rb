# Require core library
require 'middleman-core'

# Extension namespace
class MiddlemanCrawler < ::Middleman::Extension

  expose_to_template :crawler

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    # require 'necessary/library'

    # set up your extension
    puts options.my_option
  end

  def after_configuration
    # Do something
  end

  # A Sitemap Manipulator
  # def manipulate_resource_list(resources)
  # end

  # helpers do
  #   def a_helper
  #   end
  # end
end
