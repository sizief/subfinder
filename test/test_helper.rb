$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'subfinder'
require 'minitest/autorun'
require 'test/unit'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

Subfinder::Logger.setting
Subfinder::Parser::Args.new %w[-l fa -u http://example.com]
