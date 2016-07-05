require 'middleman-core'

Dir[File.join File.dirname(__FILE__), 'middleman-crawler', '**', '*.rb'].each {|file| puts file; require file }

::Middleman::Extensions.register :crawler, Crawler
