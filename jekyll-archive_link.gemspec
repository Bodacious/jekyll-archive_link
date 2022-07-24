# frozen_string_literal: true

$LOAD_PATH << File.expand_path("lib", __dir__)

require "jekyll/archive_link/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-archive_link"
  spec.version       = Jekyll::ArchiveLink::VERSION
  spec.authors       = ["Bodacious"]
  spec.email         = ["gavin@gavinmorrice.com"]

  spec.summary       = "Adds a link to Archive.org's wayback machine"
  spec.description   = <<~DESC
    Adds a link to Archive.org's wayback machine's latest capture
  DESC
  spec.homepage      = "https://github.com/bodacious/jekyll-archive_link"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0 ")
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bodacious/jekyll-archive_link"
  spec.metadata["changelog_uri"] = "https://github.com/bodacious/jekyll-archive_link/blob/main/History.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{\A(?:spec)/})
    end
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday"
  spec.add_dependency "faraday-http-cache"
  spec.add_dependency "jekyll"
  spec.add_dependency "liquid"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "webmock"
  spec.metadata["rubygems_mfa_required"] = "true"
end
