module Subfinder
  class Main
    class << self
      def run(args)
        Subfinder::Logger.setting
        Subfinder::Parser::Args.new args
        Subfinder::Subtitle.new.match
      end
    end
  end
end
