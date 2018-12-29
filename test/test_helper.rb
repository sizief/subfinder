$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'subfinder'

require 'minitest/autorun'

Subfinder::Logger.setting
Subfinder::Parser::Args.new %w[-l fa -u http://example.com]
