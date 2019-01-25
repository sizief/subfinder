module Subfinder
  class Subtitle
    def initialize(files)
      @files = files
      @success = 0
      @failure = 0
    end

    def match
      @files.each do |file|
        next unless Subfinder::Config.video_formats.include? File.extname(file)

        episode = file.scan(/[a-zA-Z]+\d+\d+[a-zA-Z]+\d+\d/)
        if episode.empty?
          Logger.info "Can not find the episode and season number for: #{File.basename(file)}".red
          @failure += 1
          next
        else
          subtitle = @files.select { |i| i[/#{episode.first}/] && i[/.srt/] }
          match_subs_to_files subtitle, file
        end
      end
      Logger.info "Sub added: #{@success}, Sub not found: #{@failure}, Total file proccessed: #{@failure + @success}".green
    end

    private

    def match_subs_to_files(subtitle, file)
      if subtitle.empty?
        Logger.info "Can not find subtitle for: #{File.basename(file)}"
        Logger.info 'Searching Subscene...'
        subscene = Subfinder::Parser.subscene.new(file)
        if subscene.run
          Subfinder::Parser::Files.prepare_file_list
          Logger.info "Subtitle downloaded for #{File.basename(file)}"
        else
          Logger.info "Subtitle can not found on Subscene for #{File.basename(file)}".red
          @failure += 1
          return
        end
      end
      File.rename(subtitle.first, File.dirname(subtitle.first) + '/' + File.basename(file).split('.')[0..-2].join('.') + '.srt')
      Logger.info "Subtitle added for: #{File.basename(file)}"
      @success += 1
    end
  end
end
