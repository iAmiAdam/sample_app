namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end
end		

def make_users
	User.create!(name: "Adam Smith",
				 email: "adam.smith18@ntlworld.com",
				 password: "foobar",
				 password_confirmation: "foobar",
				 admin: true,
				 username: "Adam")
	5.times do |n|
		name = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(name: name,
					 email: email,
					 password: password,
					 password_confirmation: password,
					 username: "Example#{n}")
	end
end

def make_microposts
	users = User.all(limit: 6)
	5.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..6]
	followers = users[3..5]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
end