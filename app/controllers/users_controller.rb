class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :already_signed_in, only: [:create, :new]


  def index
    @users = User.paginate(page: params[:page])
  end

  def show 
  	@user = User.ci_find('username', params[:username])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      token = verify_token @user
      @user.update_attribute(:token, token)
      sign_in @user
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Welcome to my Twitter Clone!"
      flash[:notice] = "Don't forget to check your email and verify your email address"
      redirect_to root_url
  	else
  		render 'new'
  	end
  end 

  def edit
    @user = current_user
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end 

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def forgot 
    
  end

  def reset
    @user = User.find_by token: params[:token]

  end

  def verify
    @user = User.find_by token: params[:token]
    if @user then
      @user.update_attribute(:verify, 1)
      flash[:success] = "Email Verified!"
      redirect_to root_path
    else
      flash[:error] = "There was an error, contact support."
      redirect_to root_path
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :username, :admin)
  	end

    def correct_user
      @user = User.ci_find('username', params[:username])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user 
      redirect_to(root_path) unless current_user.admin?
    end

    def already_signed_in
      if signed_in?
        flash[:notice] = "You're already signed in, silly!"
        redirect_to root_path
      end
    end

    def verify_token(user)
      token = Digest::MD5::hexdigest(user.email.downcase)
    end
end