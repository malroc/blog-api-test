class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = paginate(@post.comments)
  end

  def show
  end

  def create
    @comment = @post.comments.new(comment_params)

    if @comment.save
      render :show, status: :created, location: [@post, @comment]
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render :show, status: :ok, location: [@post, @comment]
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.fetch(:comment).permit(:body)
  end
end
