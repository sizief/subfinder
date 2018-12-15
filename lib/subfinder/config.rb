module Subfinder
  class Config
    class << self
      attr_reader :subtitles
      
      def settings
        @subtitles = ["ali", "mamad"]
      end
    end
  end
end
  