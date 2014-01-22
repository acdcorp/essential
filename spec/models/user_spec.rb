require 'spec_helper'

describe User do
  it { expect(User.reflect_on_association(:role)).not_to be nil}
end
