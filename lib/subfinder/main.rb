# frozen_string_literal: true

module Subfinder

  # Initialize config and then search and match subtitles
  class Main
    class << self
      def run(args)
        Logger.setting
        Parser::Args.new args
        Subtitle.new.match
      end
    end
  end
end
