module Subfinder
  class Subtitle
    def initialize files
      @files = files
    end

    def match
      @files.each do |file|
        if Subfinder::Config.video_formats.include? File.extname(file) 
          episode = file.scan(/[a-zA-Z]+\d+\d+[a-zA-Z]+\d+\d/)
          if episode.empty?
            Logger.info "Can not find the episode and season number for: #{file}".red
            next
          else
            subtitle =  @files.select{ |i| i[/#{episode.first}/] and i[/.srt/] }
            if subtitle.empty?
              Logger.info "Can not find subtitle for: #{file}".red
            else
              File.rename(subtitle.first, File.dirname(subtitle.first)+"/" + File.basename(file).split(".")[0..-2].join(".") + ".srt")
            end
          end
        end
      end
    end

  end
end
