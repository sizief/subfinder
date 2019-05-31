module Subfinder
  class Subtitle
    
    def initialize
      @success = 0
      @failure = 0
    end

    def match
      Parser::Files.list.each do |video_file|
        # only consider video file types listed in confi
        next unless Config.video_formats.include? File.extname(video_file)
        next if subtitle_exists? video_file

        if episode_number(video_file).nil?
          Logger.info "Can not find the episode and season number for: #{File.basename(video_file)}".red
          @failure += 1
          next
        else
          find_subtitle_for video_file
        end
      end
      Logger.info "Sub added: #{@success}, Sub not found: #{@failure}, Total file proccessed: #{@failure + @success}".green
    end

    private

    def episode_number(video_file)
      video_file.scan(/[a-zA-Z]+\d+\d+[a-zA-Z]+\d+\d/).first.downcase
    end

    def subtitle_exists?(video_file)
      subtitle_file_name =  video_file.split('.')[0..-2].join('.') + '.srt'
      if Parser::Files.list.include? subtitle_file_name
        return true
      end
    end

    def find_subtitle_for(video_file)
      subtitles = Parser::Files.list.select { |item| item[/#{episode_number(video_file)}/i] && item[/.srt/] }
      if subtitles.empty?
        Logger.info "Subtitle for #{File.basename(video_file)} is not exists on disk. Trying to download..."
        subscene = Parser::Subscene.new(video_file)
        if !Config.url.nil? && subscene.get
          Parser::Files.prepare_file_list
          Logger.info "Subtitle downloaded for #{File.basename(video_file)}"
        else
          Logger.info "Subtitle can not found on Subscene for #{File.basename(video_file)}".red
          Logger.info 'Please provide a url with "-u" siwtch'.red if Config.url.nil?
          @failure += 1
          return
        end
      end
      rename_subtitle video_file
    end

    def rename_subtitle(video_file)
      subtitles = Parser::Files.list.select do
        |item| item[/#{episode_number(video_file)}/i] && item[/.srt/] 
      end
      video_name = File.basename(video_file).split('.')[0..-2].join('.')
      subtitle_name = File.dirname(subtitles.first) + '/' + video_name  + '.srt'
      File.rename(subtitles.first, subtitle_name)
      Logger.info "Subtitle renamed for: #{File.basename(video_file)}"
      @success += 1
    end
  end
end
