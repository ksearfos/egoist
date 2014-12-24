require 'rspec'
require 'egoist'
require 'pathname'

here = Pathname.new File.dirname(__FILE__)
Dir[here.join('support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.color = :enabled
  config.fail_fast = true
  config.formatter = :documentation
end
