# frozen_string_literal: true

module Subfinder
  # Configuration for different running modes
  class Config
    @video_formats = %w[.avi .mp4 .mkv]
    class << self
      attr_accessor :subtitles, :language, :url, 
                    :working_dir, :video_formats, :debug,
                    :quiet  
    end
  end
end
