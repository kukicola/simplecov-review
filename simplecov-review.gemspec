# frozen_string_literal: true

require_relative 'lib/simplecov-review/version'

Gem::Specification.new do |spec|
  spec.name          = 'simplecov-review'
  spec.version       = SimpleCov::Formatter::ReviewFormatter::VERSION
  spec.authors       = ['Karol Bąk']
  spec.email         = ['kukicola@gmail.com']

  spec.summary       = 'SimpleCov formatter to generate missing lines errors for reporting tools like reviewdog'
  spec.homepage      = 'https://github.com/kukicola/simplecov-review'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'simplecov', '>= 0.21.2', '< 0.23'
end
