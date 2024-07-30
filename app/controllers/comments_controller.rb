class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]
  before_action :authenticate_request

  def create
    @comment = @post.comments.build(comment_params.merge(user_id: @current_user.id))
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.user_id == @current_user.id && @comment.update(comment_params)
      render json: @comment
    else
      render json: { errors: 'Unauthorized or invalid data' }, status: :unauthorized
    end
  end

  def destroy
    if @comment.user_id == @current_user.id
      @comment.destroy
      render json: { message: 'Comment deleted' }, status: :ok
    else
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Post not found' }, status: :not_found
  end


  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
