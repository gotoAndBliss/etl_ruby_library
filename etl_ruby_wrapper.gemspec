# frozen_string_literal: true

require_relative "lib/etl_ruby_wrapper/version"

Gem::Specification.new do |spec|
  spec.name = "etl_ruby_wrapper"
  spec.version = EtlRubyWrapper::VERSION
  spec.authors = ["Trip Shanti"]
  spec.email = ["dev@sanskrit.one"]

  spec.summary = "A Ruby wrapper for running custom ETL (Extract, Transform, Load) processes using a Go binary."
  spec.description = "EtlRubyWrapper is a Ruby gem designed to facilitate ETL (Extract, Transform, Load) operations by executing a Go binary. This gem allows you to easily run ETL processes by managing the binary execution and error handling within a Ruby application. It's ideal for projects that need efficient data processing but prefer leveraging Ruby's simplicity for orchestration."
  spec.homepage = "https://github.com/gotoAndBliss/etl_ruby_wrapper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ go/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
