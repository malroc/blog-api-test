class LikesController < ApplicationController
  before_action :set_like, only: [:show, :destroy]

  def show
  end

  def create
    @like = Like.find_by(like_attributes)
    if @like
      render :show, status: :found, location: post_like_url(params[:post_id])
    else
      @like = Like.create(like_attributes)
      render :show, status: :created, location: post_like_url(params[:post_id])
    end
  end

  def destroy
    @like.destroy
  end

  private

  def set_like
    @like = Like.find_by!(like_attributes)
  end

  def like_attributes
    { post_id: params[:post_id], user_id: current_user.id }
  end
end
