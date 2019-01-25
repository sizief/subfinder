require 'test_helper'

class FilesTest < Minitest::Test
  def setup
    @current_dir = Dir.pwd + '/test/samples/play_ground'
    Dir.mkdir(@current_dir)
    Dir["#{Dir.pwd}/test/samples/compressed_files/*"].each { |f| FileUtils.copy(f, @current_dir + '/' + File.basename(f)) }
    Subfinder::Config.working_dir = @current_dir
  end

  def setup_test
    files = Dir["#{Subfinder::Config.working_dir}/*"]
    assert_equal files.size, 3, files.to_s
    assert files.all? { |x| x.include?('.zip') || x.include?('.rar') }
  end

  def teardown
    FileUtils.rm_r @current_dir
  end

  def test_file_list
    setup_test
    Subfinder::Parser::Files.prepare_file_list
    files = Dir["#{Subfinder::Config.working_dir}/*"]
    assert_equal files.size, 4, files.to_s
    assert !files.all? { |x| x.include?('.zip') || x.include?('.rar') }
    assert !files.all? { |x| x.include? '.srt' }
  end
end
