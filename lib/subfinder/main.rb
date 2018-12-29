module Subfinder
  class Main
    class << self
      def run(args)
        Subfinder::Logger.setting
        Logger.info welcome_message
        Subfinder::Parser::Args.new args
        subtitle = Subfinder::Subtitle.new  Subfinder::Parser::Files.list
        subtitle.match
      end

      def welcome_message
        'welcome to subfinder Gem!'.green
      end
    end
  end
end
