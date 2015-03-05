require 'rails_helper'

describe User do
  it "is valid with a name, email, password, and confirmed" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "role is set to standard" do
    user = build(:user)
    expect(user.role).to eq 'standard'
  end
end