class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost Added!"
			@feed_items = current_user.feed.paginate(page: params[:page])
			@feed_item = @micropost
			respond_to do |format|
				format.html { redirect_to root_url }
				format.js 
			end
		else
			@feed_items = []
			flash[:error] = "Failed to create micropost!"
			render 'static_pages/home'
		end
	end

	def destroy 
		@micropost.destroy
		flash[:success] = "Micropost deleted!"
			redirect_to root_url	
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end