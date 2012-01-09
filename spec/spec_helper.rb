require 'inside_sales'
require 'rspec'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.stub_with :webmock # or :fakeweb
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
