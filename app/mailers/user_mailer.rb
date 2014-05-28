class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
  	@user = user
  	@url = "#{root_url}/verify/#{user.token}"
  end

  def new_follower(user)
  	@user = user
  	@url = "#{root_url}/#{user.username}"
  end
end
