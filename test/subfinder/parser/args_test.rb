require 'test_helper'

class ArgsTest < Minitest::Test
  def setup
    @args = Subfinder::Parser::Args.new %w[-l fa -u http://example.com]
  end

  def test_config_should_set
    assert_equal Subfinder::Config.language, 'fa'
  end
end
