$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$ROOT_PATH = File.expand_path('../../', __FILE__).freeze

require 'bank_exchange_api'
require 'pry'
require 'webmock/rspec'
require 'vcr'
require 'dotenv'

Dotenv.load

VCR.configure do |config|
  config.cassette_library_dir = File.join($ROOT_PATH, 'spec', 'fixtures', 'vcr')
  config.hook_into :webmock
  #  RSpec.describe 'Overview', vcr: {cassette_name: 'overview', record: :new_episodes} do ... end
  config.default_cassette_options = {allow_playback_repeats: true, record: :new_episodes}
  config.configure_rspec_metadata!
end

Dir[File.join($ROOT_PATH, 'spec', 'support', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 3
  config.order = :random
  Kernel.srand config.seed
end
