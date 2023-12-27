class Auth::SessionsController < ApplicationController
  def index
    if current_user
      render json: {is_login: true, data: current_user}
    else
      render json: {is_login: falase, message: "Please login first."}
    end
  end
end
