require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.register_request_matcher :port do |request_1, request_2|
    URI(request_1.uri).port == URI(request_2.uri).port
  end
  c.hook_into :webmock
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, :match_requests_on => [:host]) { example.call }
  end
end

