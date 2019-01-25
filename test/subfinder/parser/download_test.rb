require 'test_helper'

class DownnloadTest < Minitest::Test
  def setup
    Subfinder::Parser::Args.new %w[-l en -u https://subscene.com/subtitles/agatha-christies-poirot-thirteenth-season/]
    @current_dir = Dir.pwd + '/test/samples/videos'
    Dir.mkdir(@current_dir)
    Subfinder::Config.working_dir = @current_dir
  end

  def teardown
    FileUtils.rm_r @current_dir
  end

  def xtest_false_save
    assert(!Subfinder::Parser::Download.new('wrong address').save)
    VCR.use_cassette('wrong_download_url') do
      assert(!Subfinder::Parser::Download
      .new('https://subscene.com/subtitles/english-text/MGNU9jG42CkOL8vcxVwLzwaKhIvuPAE0Bb7OqO62gY8-mFppv1EKkdjJVrTFiRBfXA2sxFE5E8je3FtYz11K6jGRckMYNf6S5LznnuUB5aV_PjsPghQ')
      .save)
    end
  end

  def test_true_save
    VCR.use_cassette('download_subtitle') do
      url = 'https://subscene.com/subtitles/english-text/sHJhr2I4lE-yw2DpHCHhU6LyQAVblnCco40Xz5BU-xauDoWZfM8IhubEeueArDbYwwz751JTHn1HgswFviy0JfUrVjFwswSoC9tjHmgomeZeWjSXSjgUnYAVQr12v6U30'.freeze
      assert(Subfinder::Parser::Download.new(url).save)
    end
  end

  def test_file_exist_after_save
    VCR.use_cassette('download_subtitle') do
      url = 'https://subscene.com/subtitles/english-text/sHJhr2I4lE-yw2DpHCHhU6LyQAVblnCco40Xz5BU-xauDoWZfM8IhubEeueArDbYwwz751JTHn1HgswFviy0JfUrVjFwswSoC9tjHmgomeZeWjSXSjgUnYAVQr12v6U30'.freeze
      Subfinder::Parser::Download.new(url).save
      assert(!Dir[Subfinder::Config.working_dir + '/*'].empty?)
    end
  end
end
