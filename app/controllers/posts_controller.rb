class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_request

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    @post = @current_user.posts.build(post_params)
    if @post.save
      PostDeleteJob.set(wait_until: @post.created_at + 24.hours).perform_later(@post.id)
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @post
  end

  def update
    if @post.user_id == @current_user.id && @post.update(post_params)
      render json: @post
    else
      render json: { errors: 'Unauthorized or invalid data' }, status: :unauthorized
    end
  end

  def destroy
    if @post.user_id == @current_user.id
      @post.destroy
      render json: { message: 'Post deleted' }, status: :ok
    else
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Post not found' }, status: :not_found
  end
  def post_params
    params.require(:post).permit(:title, :body, :tags)
  end
end