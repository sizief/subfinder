module Subfinder
  class Main
    class << self
      def run(args)
        Subfinder::Logger.setting
        Logger.info welcome_message
        Subfinder::Parser::Args.new args
        Subfinder::Subtitle.new.match
      end

      def welcome_message
        'welcome to subfinder Gem!'.green
      end
    end
  end
end
