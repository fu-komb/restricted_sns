class HomeController < ApplicationController
	def index
		return render json: { status: "Your environment is successfully built." }
	end
end
