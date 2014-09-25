require 'rails_helper'

RSpec.describe "triggers/index", :type => :view do
  before(:each) do
    assign(:triggers, [
      Trigger.create!(
        :device => nil,
        :title => "Title",
        :email => "Email",
        :property => "Property",
        :operation => "Operation",
        :value => "Value",
        :message => "Message"
      ),
      Trigger.create!(
        :device => nil,
        :title => "Title",
        :email => "Email",
        :property => "Property",
        :operation => "Operation",
        :value => "Value",
        :message => "Message"
      )
    ])
  end

  it "renders a list of triggers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Property".to_s, :count => 2
    assert_select "tr>td", :text => "Operation".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
  end
end
