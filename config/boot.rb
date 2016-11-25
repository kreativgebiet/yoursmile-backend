
Encoding.default_external = 'UTF-8'
Encoding.default_internal = 'UTF-8'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
