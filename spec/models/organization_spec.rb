require 'rails_helper'

describe Organization do
  it { should belong_to(:cause) }

  it { should have_valid(:name).when("Girl Develop It", "826 Boston") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:description).when("Helps women gain tech skills") }
  it { should_not have_valid(:description).when(nil, "") }

  it { should have_valid(:street).when("Commonwealth Ave") }
  it { should_not have_valid(:street).when(nil, "") }

  it { should have_valid(:city).when("Phoenix", "Boston") }
  it { should_not have_valid(:city).when(nil, "") }

  it { should have_valid(:state).when("MA", "Massachusetts") }
  it { should_not have_valid(:state).when(nil, "") }

end
