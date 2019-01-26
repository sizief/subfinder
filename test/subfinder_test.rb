require 'test_helper'

class SubfinderTest < Minitest::Test
  def setup 
    Subfinder::Logger.setting
    Subfinder::Parser::Args.new %w[--url https://subscene.com/subtitles/the-kominsky-method -l fa]
    @current_dir = Dir.pwd + '/test/samples/integration_playground'
    Dir.mkdir(@current_dir)
    Subfinder::Config.working_dir = @current_dir
    @file_name = 'the.kominsky.method.s01e08.webrip.x264-strife[eztv]'
    File.open("#{@current_dir}/#{@file_name}.mkv", 'w') { |f| f.write('this is sample file') }
  end
  
  def test_that_it_has_a_version_number
    refute_nil ::Subfinder::VERSION
  end

  def test_integration
    VCR.use_cassette('integration_test') do
      Subfinder::Subtitle.new.match
    end
    assert File.exist? "#{@current_dir}/#{@file_name}.srt"
  end

  def teardown
    FileUtils.rm_r @current_dir
  end
end

