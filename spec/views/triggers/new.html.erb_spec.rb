require 'rails_helper'

RSpec.describe "triggers/new", :type => :view do
  before(:each) do
    assign(:trigger, Trigger.new(
      :device => nil,
      :title => "MyString",
      :email => "MyString",
      :property => "MyString",
      :operation => "MyString",
      :value => "MyString",
      :message => "MyString"
    ))
  end

  it "renders new trigger form" do
    render

    assert_select "form[action=?][method=?]", triggers_path, "post" do

      assert_select "input#trigger_device_id[name=?]", "trigger[device_id]"

      assert_select "input#trigger_title[name=?]", "trigger[title]"

      assert_select "input#trigger_email[name=?]", "trigger[email]"

      assert_select "input#trigger_property[name=?]", "trigger[property]"

      assert_select "input#trigger_operation[name=?]", "trigger[operation]"

      assert_select "input#trigger_value[name=?]", "trigger[value]"

      assert_select "input#trigger_message[name=?]", "trigger[message]"
    end
  end
end
