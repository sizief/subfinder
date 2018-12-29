require 'test_helper'

class FilesTest < Minitest::Test
  def setup
    @current_dir = Dir.pwd+"/test/samples/compressed"
    Subfinder::Config.working_dir = @current_dir
  end

  def setup_test
    files = Dir["#{Subfinder::Config.working_dir}/*"]
    assert_equal files.size, 3, "#{files}"
    assert files.all? {|x| x.include? ".zip" or x.include? ".rar"}
  end

  def test_file_list
    setup_test
    Subfinder::Parser::Files.prepare_file_list 
    files = Dir["#{Subfinder::Config.working_dir}/*"]
    assert_equal files.size, 4, "#{files}"
    assert !files.all? {|x| x.include? ".zip" or x.include? ".rar"}
    assert !files.all? {|x| x.include? ".srt"}
    revert_to_starting_phase
  end

  def revert_to_starting_phase
    #move compressed files back to one level upper directory
    Dir["#{@current_dir}/compressed/*"].each {|f| File.rename(f, @current_dir+"/"+File.basename(f))}
    #delete compressed folder and extracted files
    Dir["#{@current_dir}/*"].each {|f| File.delete(f) if f.include? ".srt" }
    Dir.rmdir "#{@current_dir}/compressed"
  end
end
