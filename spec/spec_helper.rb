require "yahoo_finance"
require "fakeweb"
require "vcr"

VCR.config do |c|
  c.cassette_library_dir = File.expand_path("cassettes", File.dirname(__FILE__))
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
