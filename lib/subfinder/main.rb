module Subfinder
  class Main
    def self.run(args)
      Subfinder::Logger.setting
      Subfinder::Parser::Args.new args
      # file_list = Subfinder::Parser::Files.list
      Logger.info Config.language.red
    end
  end
  end
