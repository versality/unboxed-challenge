# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'vcr'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../config/environment.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure { |c| c.include RSpecMixin }

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
