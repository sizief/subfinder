module Subfinder
  class Subtitle
    def initialize
      @success = 0
      @failure = 0
    end

    def match
      Subfinder::Parser::Files.list.each do |video_file|
        next unless Subfinder::Config.video_formats.include? File.extname(video_file)
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
      return true if Subfinder::Parser::Files.list.include? video_file.split('.')[0..-2].join('.') + '.srt'
    end

    def find_subtitle_for(video_file)
      subtitles = Subfinder::Parser::Files.list.select { |item| item[/#{episode_number(video_file)}/i] && item[/.srt/] }
      if subtitles.empty?
        Logger.info "Subtitle for #{File.basename(video_file)} is not exists on disk "
        subscene = Subfinder::Parser::Subscene.new(video_file)
        if subscene.get
          Subfinder::Parser::Files.prepare_file_list
          Logger.info "Subtitle downloaded for #{File.basename(video_file)}"
        else
          Logger.info "Subtitle can not found on Subscene for #{File.basename(video_file)}".red
          @failure += 1
          return
        end
      end
      rename_subtitle video_file
    end

    def rename_subtitle(video_file)
      subtitles = Subfinder::Parser::Files.list.select { |item| item[/#{episode_number(video_file)}/i] && item[/.srt/] }
      File.rename(subtitles.first, File.dirname(subtitles.first) + '/' + File.basename(video_file).split('.')[0..-2].join('.') + '.srt')
      Logger.info "Subtitle renamed for: #{File.basename(video_file)}"
      @success += 1
    end
  end
end
