require 'middleman-core/cli'
require 'middleman-core/rack' if Middleman::VERSION.to_i > 3
require 'middleman-deploy/extension'

require 'rawler'

module Middleman
  module Cli
    # This class provides a "crawler" command for the middleman CLI.
    class CrawlerIndex < Thor::Group
      include Thor::Actions

      check_unknown_options!

      namespace :crawler

      class_option :environment,
                   aliases: '-e',
                   type: :string,
                   default: ENV['MM_ENV'] || ENV['RACK_ENV'] || 'development',
                   desc: 'The environment Middleman will run under'

      class_option :username,
                   aliases: '-u',
                   type: :string,
                   desc: 'HTTP Basic Username'

      class_option :password,
                   aliases: '-p',
                   type: :string,
                   desc: 'HTTP Basic Password'

      class_option :skip,
                   aliases: '-s',
                   type: :string,
                   default: "\#$",
                   desc: 'Skip URLs that match a regexp'

      class_option :wait,
                   aliases: '-w',
                   type: :numeric,
                   default: 0.1,
                   desc: "Seconds to wait between requests, may be fractional e.g. '1.5' (default: 3.0)"

      class_option :css,
                   aliases: '-c',
                   type: :boolean,
                   default: true,
                   desc: "Check CSS links"

      class_option :local,
                   type: :boolean,
                   default: true,
                   desc: "Restrict to the given URL and below. Equivalent to '--include ^http://mysite.com/*'."

      class_option :log,
                   aliases: '-l',
                   type: :boolean,
                   desc: "Log results to file rawler_log.txt"

      class_option :logfile,
                   aliases: '-o',
                   type: :string,
                   desc: "Specify logfile, implies --log (default: rawler_log.txt)"

      class_option :iskip,
                   aliases: '-i',
                   type: :string,
                   desc: "Skip URLs that match a case insensitive regexp"

      class_option :include,
                   type: :string,
                   desc: "Only include URLs that match a regexp"

      class_option :iinclude,
                   type: :string,
                   desc: "Only include URLs that match a case insensitive regexp"

      class_option :ignore_fragments,
                   type: :boolean,
                   desc: "Strips any fragment from parsed links"


      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      def crawler
        configs = get_configs

        env_config = File.join(Middleman::Application.root, 'environments', "#{configs[:environment]}.rb")
        return unless File.exist? env_config

        configurations = Configure.new

        configurations.instance_eval File.read(env_config), env_config, 1

        response = {}
        raw = Rawler::Base.new(configurations.config[:base_url], $stdout, rawler_options)
        raw.validate
        response['errors'] = raw.responses.reject{ |link, response|
          (100..399).include?(response[:status].to_i)
        }
        say("There are some errors: #{errors_message_for(response['errors'])}", :red) if response['errors']
        puts "All crawling actions ok" unless response['errors']
      end

      private

      def get_configs
        configs ||= {
          environment: (options['environment'].presence || "development").to_sym,
          username: options['username'],
          password: options['password'],
          skip: options['skip'],
          wait: options['wait'],
          css: options['css'],
          local: options['local'],
          log: options['log'],
          logfile: options['logfile'],
          iskip: options['iskip'],
          include: options['include'],
          iinclude: options['iinclude'],
          ignore_fragments: options['ignore_fragments']
        }
      end

      def rawler_options
        opts = {}
        opts[:username] = get_configs[:username].to_s if get_configs[:username].present?
        opts[:password] = get_configs[:password].to_s if get_configs[:password].present?
        opts[:skip] = get_configs[:skip].present? ? get_configs[:skip].to_s : "\#$"
        opts[:wait] = get_configs[:wait].present? ? get_configs[:wait].to_f : 0.1
        opts[:css] = get_configs[:css] != nil ? get_configs[:css] : true
        opts[:local] = get_configs[:local] != nil ? get_configs[:local] : true
        opts[:log] = get_configs[:log] if get_configs[:log] != nil
        opts[:logfile] = get_configs[:logfile].to_s if get_configs[:logfile].present?
        opts[:iskip] = get_configs[:iskip].to_s if get_configs[:iskip].present?
        opts[:include] = get_configs[:include].to_s if get_configs[:include].present?
        opts[:iinclude] = get_configs[:iinclude].to_s if get_configs[:iskip].present?
        opts[:ignore_fragments] = get_configs[:ignore_fragments] if get_configs[:ignore_fragments] != nil
        opts
      end

      def errors_message_for(responses)
        collection = responses.each_with_object([])  do |(url, response), a|
          a << "url: #{url}, error_code: #{response[:status]}"
        end

        collection.join("; ")

      end

      class Configure

        attr_reader :config

        def initialize
          @config = {}
        end
      end

    end

    # Add to CLI
    Base.register(Middleman::Cli::CrawlerIndex, 'crawler', 'crawler [options]', "Starts a crawler")
  end
end
