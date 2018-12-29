module Subfinder
  class Config
    class << self
      attr_accessor :subtitles, :language, :url, :working_dir, :file_list
    end
  end
end
