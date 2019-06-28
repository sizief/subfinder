# frozen_string_literal: true

module Subfinder
  module Parser
    class Args
      # Initialze and parse input args
      def initialize(args)
        @args = args
        parse_args
        set_default_values
      end

      def parse_args
        opts = OptionParser.new
        opts.banner = usage_msg
        opts.separator ''
        opts.separator 'options:'
        opts.on('-u', '--url url', 'Set Subscene url page') { |url| Config.url = url }
        opts.on('-l', '--language language', 'Set subtitle language') { |language| Config.language = language }
        opts.on('-v', '--version', 'Show the Subfinder version') { puts("Subfinder #{Subfinder::VERSION}"); exit }
        opts.on('-h', '--help', 'You used it just now') { puts(opts); exit }
        opts.on('-d', '--debug', 'Run in debug mode') { Config.debug = true }
        opts.on('-q', '--quiet', 'Display no message') { Config.quiet = true }
        opts.on('--dryrun', 'Test application on mock files') { Subfinder::Dryrun.enable }

        opts.parse!(@args)
      end

      private

      def set_default_values
        # Set English as a default value for subtitle language if not provided
        Config.language ||= 'en'
        Config.working_dir ||= Dir.pwd
      end

      def usage_msg
        usage = '
          Usage:
            subfinder [options]
            See https://github.com/sizief/subfinder for more information.
        '
        usage
      end
    end
  end
end
