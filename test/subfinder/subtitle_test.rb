require 'test_helper'

class SubtitleTest < Minitest::Test
  def setup
    Subfinder::Parser::Args.new %w[-l fa -u http://example.com]
    @current_dir = Dir.pwd + '/test/samples/videos'
    Dir.mkdir(@current_dir)
    Subfinder::Config.working_dir = @current_dir
    create_files
  end

  def test_match
    missing_files = []
    subtitle = Subfinder::Subtitle.new(Subfinder::Parser::Files.list).match

    Dir["#{@current_dir}/*"].each do |file|
      if Subfinder::Config.video_formats.include? File.extname(file) # it is a vidoe file
        subtitle_file = @current_dir + '/' + File.basename(file).split('.')[0..-2].join('.') + '.srt'
        missing_files << subtitle_file unless File.exist? subtitle_file
      end
    end
    FileUtils.rm_r @current_dir
    assert missing_files.empty?, "this is missing: #{missing_files}"
  end

  private

  def create_files
    files = %w(
      Mechanism.The.S01E01.1080p.5.1Ch.BluRay.ReEnc-DeeJayAhmed.mkv
      The.Mechanism.S01E02.HDTV.x264-SVA[eztv].mkv
      The.Mechanism.S01E03.1080p.HDTV.x264.hastidl.mp4
      The.Mechanism.S01E04.720p.WEB-DL.DibaMoviez.mkv
      The.Mechanism.S01E05.HDTV.XviD-AFG.avi
      The.Mechanism.S01E01.WEB-DL.srt
      The.Mechanism.S01E02.HDTV.x264-SVA.srt
      The.Mechanism.S01E03.720p.HDTV.x264-IMMERSE.srt
      The.Mechanism.S01E04.HDTV.x264.KILLERS.HI.srx.srt
      The.Mechanism.S01E05.720p.WEB.H264-MEMENTO.srt
    )
    files += ['The Mechanism S01E06 - The Silkworm pt1 x264 RB58.mp4',
              'The Mechanism S01E06.pilot.720p BluRay BRRip 480p BoB-edited version.srt']

    files.each do |name|
      File.open(@current_dir + '/' + name, 'w') { |f| f.write('this is sample file') }
    end
  end
end
