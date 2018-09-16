# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../', __dir__))
APP_NAME = APP_ROOT.basename.to_s

# Require gems we care about
require 'rubygems'
require 'pathname'
require 'logger'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?
require 'erb'
require 'dotenv' if development? || test?
require 'json'
require 'graphql/client'
require 'graphql/client/http'

# Load dotenv file
Dotenv.load if development? || test?

configure do
  # By default,
  # Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path

  # Set the views to
  set :views, File.join(Sinatra::Application.root, 'app', 'views')
end

# Set up controllers
Dir[APP_ROOT.join('app', 'controllers/**', '*.rb')].each { |file| require file }

# Set up lib
Dir[APP_ROOT.join('lib/**', '*.rb')].each { |file| require file }
