module Subfinder
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
        @logger.info(str)
      end

      def debug(str)
        @logger.info(str) if Config.debug
      end
    end
  end
end
