class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
  	@user = user
  	@url = "#{root_url}/verify/#{user.token}"
  	mail(to: @user.email, subject: "Welcome to my clone!")
  end

  def new_follower(user)
  	@user = user
  	@url = "#{root_url}/#{user.username}"
  	mail(to: current_user.email, subject: "You gained a follower!")
  end
end
