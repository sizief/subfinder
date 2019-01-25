require 'test_helper'

class DownnloadTest < Minitest::Test
  # def setup
  #   @current_dir = Dir.pwd + '/test/samples/compressed'
  #   Subfinder::Config.working_dir = @current_dir
  # end

  def test_save
    assert_not Subfinder::Parser::Download.save 'wrong address'
  end
end
