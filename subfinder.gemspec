lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subfinder/version'

Gem::Specification.new do |spec|
  spec.name          = 'subfinder'
  spec.version       = Subfinder::VERSION
  spec.authors       = ['sizief']
  spec.email         = ['sizief@gmail.com']

  spec.summary       = 'Find or rename subtitle for your videos'
  spec.description   = 'I would rename your current subtitle to amtch your video files or if it is not available then I would download it!'
  spec.homepage      = 'https://github.com/sizief/subfinder'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'colorize', '~> 0.8'
  spec.add_runtime_dependency 'rubyzip', '~> 1.2.2'
end
