require 'rails_helper'

RSpec.describe Wiki, :type => :model do

  it "is valid with a title and body" do
    wiki = Wiki.new(
      title: 'Test',
      body:  'This is a test for the wiki.')
    expect(wiki).to be_valid
  end

  it "belongs to a user" do
    wiki = Wiki.new
    user = User.new
    user.wikis << wiki
    expect(wiki.user).to be user
  end
end
