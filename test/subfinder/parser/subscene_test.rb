require 'test_helper'

class SubsceneTest < Minitest::Test
  def setup
    Subfinder::Parser::Args.new %w[-l fa -u https://subscene.com/subtitles/o-mecanismo]
    @current_dir = Dir.pwd + '/test/samples/videos'
    Dir.mkdir(@current_dir)
    Subfinder::Config.working_dir = @current_dir
    @subscene_sub = Subfinder::Parser::Subscene.new 'Agatha.Christies.Poirot.S13E02.1080p.BluRay.x264.mkv'
  end
  
  def teardown
    FileUtils.rm_r @current_dir
  end

  def test_find_link
    assert_equal @subscene_sub.link, 'https://subscene.com/subtitles/agatha-christies-poirot-thirteenth-season/english/1576760'
  end

  def test_download_file
    @subscene_sub.download
    assert File.exist? @current_dir+'/S13E02.1080p.BluRay.x264-YELLOWBiRD.srt'
  end
end
