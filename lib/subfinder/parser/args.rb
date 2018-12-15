module Subfinder
      module Parser
      class Args
        def initialize(args)
          @args = args
          parse_args
          validate_required_args
        end
  
        def parse_args
          opts = OptionParser.new
          opts.banner = usage_msg
          opts.separator ''
          opts.separator 'options:'
          opts.on('-u', '--url url', 'Set subscene url page') {|url| Config.url = url }
          opts.on('-l', '--language language', 'Set subtitle language') {|language| Config.language = language }
          opts.on('-v', '--version', 'Show the Compare Crypto version') { puts("compare-crypto #{CompareCrypto::VERSION}"); exit }
          opts.on('-h', '--help', 'Show this message') { puts(opts); exit }
          opts.parse!(@args)
        end
        
        private
        
        def validate_required_args 
          Config.language ||= 'en'
        end
        
        def usage_msg
          <<~USAGE.freeze
          Usage:
            subfinder [options]
            See https://github.com/sizief/subfinder for more information.
          USAGE
        end


  
      end
    end
  end
  