require 'spec_helper'

steps_for :screenshot do
  after :each do
    take_screenshot 'debug'
  end
end
