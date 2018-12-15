module Subfinder
  class Subtitle
    def initialize 
      @subtitles = Config.subtitles
    end

    def find video_file_name
      match = nil
      @subtitles.each do |subtitle|
        #match = subtitle if 
      end
      match
    end
  end
  
end
