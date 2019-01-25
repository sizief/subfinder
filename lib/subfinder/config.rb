module Subfinder
  class Config
    @video_formats = %w[.avi .mp4 .mkv]
    class << self
      attr_accessor :subtitles, :language, :url, :working_dir, :video_formats, :debug
    end
  end
end
