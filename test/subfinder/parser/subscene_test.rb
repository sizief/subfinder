require 'test_helper'

class SubsceneTest < Minitest::Test
  def setup
    Subfinder::Parser::Args.new %w[-l en -u https://subscene.com/subtitles/agatha-christies-poirot-thirteenth-season/]
    @current_dir = Dir.pwd + '/test/samples/videos'
    Dir.mkdir(@current_dir)
    Subfinder::Config.working_dir = @current_dir
    @name = 'Agatha.Christies.Poirot.S13E02.1080p.BluRay.x264.mkv'
    @subscene_sub = Subfinder::Parser::Subscene.new @name
  end
  
  def teardown
    FileUtils.rm_r @current_dir
  end

  def test_create_links_list
    res = @subscene_sub.create_links_list(File.read(Dir.pwd + '/test/mocks/subscene_listpage'))
    assert res[-1][0], 'Portuguese'
  end

  def test_match_point_for
    assert_equal @subscene_sub.match_point_for(@name), 100
    assert_equal @subscene_sub.match_point_for('Agatha.Christies.Poirot.S13E02'), 50
    assert_equal @subscene_sub.match_point_for('Agathaa.Chriasties.Poairot'), 0
    assert_equal @subscene_sub.match_point_for("#{@name}.extra"), 100
    assert_equal @subscene_sub.match_point_for("not.a.movie"), 0
    assert_equal @subscene_sub.match_point_for("not a movie"), 0
    assert_equal @subscene_sub.match_point_for('Agatha Christies Poirot S13E02 1080p BluRay x264 mkv'), 100
    assert_equal @subscene_sub.match_point_for('Christies S13E02 BluRay mkv'), 50
  end

  def test_find_link
    res = @subscene_sub.create_links_list(File.read(Dir.pwd + '/test/mocks/subscene_listpage'))
    assert_equal @subscene_sub.find_link(res), '/subtitles/agatha-christies-poirot-thirteenth-season/english/1811318'
    @subscene_sub = Subfinder::Parser::Subscene.new 'Agatha.Christies.Poirot.S1308.1080p.BluRay.x264.mkv'
    assert_equal @subscene_sub.find_link(res), '/subtitles/agatha-christies-poirot-thirteenth-season/english/1811318'
  end

  def xtest_download_file
    @subscene_sub.download
    assert File.exist? @current_dir+'/S13E02.1080p.BluRay.x264-YELLOWBiRD.srt'
  end
end
