require 'spec_helper'

steps_for :screenshot do
  after :each, screenshot: true do
    take_screenshot 'debug'
  end
end

steps_for :ff_remote do
  before :each, ff_remote: true do
    Capybara.current_driver = :ff_remote
  end
end

step('binding.pry') { binding.pry }
