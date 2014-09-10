# This will guess the User class
FactoryGirl.define do
	#sequences
	sequence :email do |n|
		"email#{n}@example.com"
	end

	sequence :name do |n|
		"Meu nome #{n}"
	end

	#factories
  factory :user do 
  	email
    password 'f4k3p455w0rd'
  end

  factory :device do
  	name
    description 'Long description on device'
  end
end