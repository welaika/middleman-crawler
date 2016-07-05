require 'middleman-core'

require 'middleman-crawler/commands'

Middleman::Extensions.register(:crawler) do
  require 'middleman-crawler/extension'
  Crawler
end
