require 'rails_helper'

RSpec.describe "triggers/show", :type => :view do
  before(:each) do
    @trigger = assign(:trigger, Trigger.create!(
      :device => nil,
      :title => "Title",
      :email => "Email",
      :property => "Property",
      :operation => "Operation",
      :value => "Value",
      :message => "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Property/)
    expect(rendered).to match(/Operation/)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(/Message/)
  end
end
