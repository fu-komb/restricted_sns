class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:id].nil?
      return render json: { error: "User ID is not specified." }, status: 400
    end

    user = User.find_by(id: params[:id])
    if user.nil?
      return render json: { error: "User not found." }, status: 404
    end

    return render json: { user: user }, status: 200
  end

  def update
    # TODO: deviceのお作法に則ったユーザー更新処理がありそうなのであとで調べる
    if params[:id].nil?
      return render json: { error: "User ID is not specified." }, status: 400
    end

    user = User.find_by(id: params[:id])
    if user.nil?
      return render json: { error: "User not found." }, status: 404
    end

    if current_user.id != user.id
      return render json: { error: "You are not allowed to update this user." }, status: 403
    end

    user.update!(user_params)

    return render json: { user: user }, status: 200
  end

  def follow
    if params[:followee_user_id].nil?
      return render json: { error: "Followee user ID is not specified." }, status: 400
    end

    followee = User.find_by(id: params[:followee_user_id])
    if followee.nil?
      return render json: { error: "Followee user not found." }, status: 404
    end

    follow = Follow.new(follower_id: current_user.id, followee_id: followee.id)
    follow.save!

    return render json: { follow: follow }, status: 200
  end

  def unfollow
    if params[:followee_user_id].nil?
      return render json: { error: "Followee user ID is not specified." }, status: 400
    end

    followee = User.find_by(id: params[:followee_user_id])
    if followee.nil?
      return render json: { error: "Followee user not found." }, status: 404
    end

    follow = Follow.find_by(follower_id: current_user.id, followee_id: followee.id)
    if follow.nil?
      return render json: { error: "Follow not found." }, status: 404
    end

    follow.destroy!

    return render json: { follow: follow }, status: 200
  end

  def block
    if params[:blockee_user_id].nil?
      return render json: { error: "Blockee user ID is not specified." }, status: 400
    end

    blockee = User.find_by(id: params[:blockee_user_id])
    if blockee.nil?
      return render json: { error: "Blockee user not found." }, status: 404
    end

    # フォロー関係の解除
    follow = Follow.find_by(follower_id: current_user.id, followee_id: blockee.id)
    if follow.present?
      follow.destroy!
    end

    follower = Follow.find_by(follower_id: blockee.id, followee_id: current_user.id)
    if follower.present?
      follower.destroy!
    end

    block = Block.new(blocker_id: current_user.id, blockee_id: blockee.id)
    block.save!

    return render json: { block: block }, status: 200
  end

  def unblock
    if params[:blockee_user_id].nil?
      return render json: { error: "Blockee user ID is not specified." }, status: 400
    end

    blockee = User.find_by(id: params[:blockee_user_id])
    if blockee.nil?
      return render json: { error: "Blockee user not found." }, status: 404
    end

    block = Block.find_by(blocker_id: current_user.id, blockee_id: blockee.id)
    if block.nil?
      return render json: { error: "Block not found." }, status: 404
    end

    block.destroy!

    return render json: { block: block }, status: 200
  end

  private
    def user_params
      params.permit(:name, :nickname, :email, :password, :password_confirmation)
    end
end
