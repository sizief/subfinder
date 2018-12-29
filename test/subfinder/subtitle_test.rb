require 'test_helper'

class SubtitleTest < Minitest::Test
  def setup
    Subfinder::Config.working_dir = Dir.pwd+"/test/samples/videos"
    Subfinder::Parser::Files.prepare_file_list 
  end

  def test_config_should_set
    assert Subfinder::Config.file_list.is_a? Array
    assert !Subfinder::Config.file_list.empty?
  end
end


#File.open("out.txt", [your-option-string]) {|f| f.write("write your stuff here") }