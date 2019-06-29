# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subfinder/version'

Gem::Specification.new do |spec|
  spec.name          = 'subfinder'
  spec.version       = Subfinder::VERSION
  spec.authors       = ['sizief']
  spec.email         = ['sizief@gmail.com']

  spec.summary       = 'Find or rename subtitle for your videos'
  spec.description   = 'Download or rename subtitle files to match video files'
  spec.homepage      = 'https://github.com/sizief/subfinder'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bundler', '~> 2.0.1'
  spec.add_runtime_dependency 'colorize', '~> 0.8'
  spec.add_runtime_dependency 'nokogiri', '~> 1.10.1'
  spec.add_runtime_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'rest-client', '~> 2.0.1'
  spec.add_runtime_dependency 'rubyzip', '~> 1.2.2'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'test-unit', '~> 3.1.8'
  spec.add_development_dependency 'vcr', '~> 4.0.0'
  spec.add_development_dependency 'webmock', '~> 3.5.1'
end
