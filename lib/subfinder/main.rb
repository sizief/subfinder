module Subfinder
  class Main
    class << self
      def run(args)
        Subfinder::Logger.setting
        Logger.info welcome_message
        Subfinder::Parser::Args.new args
        Subfinder::Parser::Files.prepare_file_list
        Subfinder::Parser::Files.list
        Logger.info Config.language.red
      end

      def welcome_message
        'welcome to subfinder Gem!'.green
      end
    end
  end
end
