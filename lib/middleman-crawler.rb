require 'middleman-core'

require 'middleman-crawler/commands.rb'

Middleman::Extensions.register :crawler do
  require 'middleman-crawler/extension'
  MiddlemanCrawler
end
