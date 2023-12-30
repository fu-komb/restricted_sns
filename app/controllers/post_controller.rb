class PostController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = User.find_by(id: current_user.id).posts
    return render json: { posts: posts }, status: 200
  end

  def create
    return render json: { error: "You are not logged in." }, status: 401 unless current_user.present?
    post = Post.new(post_params.merge(user_id: current_user.id))
    post.save!

		return render json: {current_user_id: current_user.id}, status: 200
  end

  def timeline
    followee_ids = Follow.where(follower_id: current_user.id).pluck(:followee_id)
    query = Post.where(host_user: current_user.followees)
    query = query.where("created_at > ?", last_got_at) if params[:last_got_at].present?
    posts = query.order(created_at: :desc)
    return render json: { posts: posts }, status: 200
  end

  private
    def post_params
      params.permit(:text, :reply_to_post_id)
    end
end