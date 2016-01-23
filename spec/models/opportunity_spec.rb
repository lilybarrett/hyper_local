require 'rails_helper'

describe Opportunity do
  it { should belong_to(:organization) }

  it { should have_valid(:description).when("Lead an HTML/CSS workshop for
    middle school girls") }
  it { should_not have_valid(:description).when(nil, "") }

  it { should have_valid(:capacity).when(2, 50) }
  it { should_not have_valid(:capacity).when(nil, "", 0, -1, 2.5) }

  it { should have_valid(:street).when("Commonwealth Ave") }
  it { should_not have_valid(:street).when(nil, "") }

  it { should have_valid(:city).when("Phoenix", "Boston") }
  it { should_not have_valid(:city).when(nil, "") }

  it { should have_valid(:state).when("MA", "Massachusetts") }
  it { should_not have_valid(:state).when(nil, "") }
end
