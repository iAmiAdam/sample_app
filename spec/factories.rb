FactoryGirl.define do 
	factory :user do
		name "Adam Smith"
		email "adamsmith@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end