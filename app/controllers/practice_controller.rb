class PracticeController < ApplicationController
  def index
    posts = Practice.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'loaded posts', data: posts }
  end

  def show
    post = Practice.find(params[:id])
    render json: { status: 'SUCCESS', message: 'loaded the post', data: post }
  end

  def create
    post = Practice.new(post_params)
    if post.save
      render json: { status: 'SUCCESS', message: 'loaded the post', data: post }
    else
      render json: { status: 'ERROR', message: 'post not saved', data: post.errors }
    end
  end

  def destroy
    post = Practice.find(params[:id])
    post.destroy
    render json: { status: 'SUCCESS', message: 'deleted the post', data: post }
  end

  def update
    post = Practice.find(params[:id])
    if post.update(post_params)
      render json: { status: 'SUCCESS', message: 'updated the post', data: post }
    else
      render json: { status: 'SUCCESS', message: 'loaded the post', data: post }
    end
  end

  private

  def post_params
    params.require(:practice).permit(:title, :message)
  end
end
