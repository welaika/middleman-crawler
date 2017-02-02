# Middleman::Crawler

Add a crawler CLI to crawl your middleman site.

[![Gem Version](https://badge.fury.io/rb/middleman-crawler.png)](http://badge.fury.io/rb/middleman-crawler)

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-crawler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-crawler

## Usage

First you need to activate the module in your `config.rb`.

```
activate :crawler
```

After you must declare in your `environments/*.rb` this config var:

```
config[:base_url] = "http://someurl.here"
```

This extension use [Rawler Gem](https://github.com/oscardelben/rawler) and implements the same interface with one more option `environment`.

In CLI you can write `middleman crawler http://example.com [options]`

      where [options] are:
        --environment, -e <s>:   The Middleman Enviroment
        --username, -u <s>:   HTTP Basic Username
        --password, -p <s>:   HTTP Basic Password
            --wait, -w <f>:   Seconds to wait between requests, may be fractional e.g. '1.5' (default: 3.0)
                 --log, -l:   Log results to file rawler_log.txt
         --logfile, -o <s>:   Specify logfile, implies --log (default: rawler_log.txt)
                 --css, -c:   Check CSS links
            --skip, -s <s>:   Skip URLs that match a regexp
           --iskip, -i <s>:   Skip URLs that match a case insensitive regexp
             --include <s>:   Only include URLs that match a regexp
            --iinclude <s>:   Only include URLs that match a case insensitive regexp
               --local <s>:   Restrict to the given URL and below. Equivalent to '--include ^http://mysite.com/*'.
        --ignore_fragments:   Strips any fragment from parsed links


## Contributing

1. Fork it ( https://github.com/welaika/middleman-crawler )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

made with ❤️ and ☕️ by [weLaika](http://dev.welaika.com)
