# frozen_string_literal: true

module Subfinder
  # Logger class, shoud initiate at the start of the program
  class Logger < ::Logger
    class << self
      def setting
        logger = Logger.new STDOUT
        logger.level = Logger::INFO
        logger.formatter = proc do |_severity, _datetime, _progname, msg|
          "#{msg}\n"
        end
        @logger = logger
      end

      def info(str)
        @logger.info(str) unless Config.quiet
      end

      def debug(str)
        @logger.info(str) if Config.debug
      end
    end
  end
end
