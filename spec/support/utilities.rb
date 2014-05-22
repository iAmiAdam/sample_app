include ApplicationHelper

def signin(user)
	fill_in "Email", with: user.email.upcase
	fill_in "Password", with: user.password
end