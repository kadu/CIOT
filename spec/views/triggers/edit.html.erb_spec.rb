require 'rails_helper'

RSpec.describe "triggers/edit", :type => :view do
  before(:each) do
    @trigger = assign(:trigger, Trigger.create!(
      :device => nil,
      :title => "MyString",
      :email => "MyString",
      :property => "MyString",
      :operation => "MyString",
      :value => "MyString",
      :message => "MyString"
    ))
  end

  it "renders the edit trigger form" do
    render

    assert_select "form[action=?][method=?]", trigger_path(@trigger), "post" do

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
