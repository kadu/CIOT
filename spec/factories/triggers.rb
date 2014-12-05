# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :trigger do
    title "rule "
    email
    property "test"
    operation "<"
    value "30"
    message "MyString message"
  end
end
