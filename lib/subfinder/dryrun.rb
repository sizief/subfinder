# frozen_string_literal: true

module Subfinder
  # Would create a folder, create fake files and run Subfinder
  class Dryrun
    class << self
      def enable
        Logger.info 'Runnign in Dryrun mode.'
        dryrun_dir = Dir.pwd + '/dryrun_test_directory'
        Dir.mkdir(dryrun_dir)
        Config.working_dir = dryrun_dir
        create_mock_files_in dryrun_dir
      end

      def mock_list_file
        # files with different subtitle file names
        files = video_subtitle_pairs

        # Files with space in their names
        files += ['The Mechanism S01E06 - The Silkworm pt1 x264 RB58.mp4',
                  'The Mechanism S01E06.pilot.720p BluRay BRRip 480p'\
                  ' BoB-edited version.srt']

        # Dingle file without subtutles
        files + %w[The.Mechanism.S02E03.1080p.HDTV.x264.mp4]
      end

      def video_subtitle_pairs
        %w(
          Mechanism.The.S01E01.1080p.5.1Ch.BluRay.ReEnc-DeeJayAhmed.mkv
          The.Mechanism.S01E02.HDTV.x264-SVA[eztv].mkv
          The.Mechanism.S01E03.1080p.HDTV.x264.mp4
          The.Mechanism.S01E04.720p.WEB-DL.DibaMoviez.mkv
          Agatha.Christies.Poirot.S13E02.1080p.BluRay.x264.mkv
          The.Mechanism.S01E01.WEB-DL.srt
          The.Mechanism.S01E02.HDTV.x264-SVA.srt
          The.Mechanism.S01E03.720p.HDTV.x264-IMMERSE.srt
          The.Mechanism.S01E04.HDTV.x264.KILLERS.HI.srx.srt
          The.Mechanism.S01E05.720p.WEB.H264-MEMENTO.srt
        )
      end

      def create_mock_files_in(folder)
        mock_list_file.each do |file_name|
          File.open(folder + '/' + file_name, 'w') do |f|
            f.write('this is sample file')
          end
        end
      end
    end
  end
end
