module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Loaded posts', data:@posts}, status: :ok
      end

      def show
        @post = Post.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded posts', data:@post}, status: :ok
      end

      def create
        @post = Post.new(post_params)

        if @post.save
          render json: {status: 'SUCCESS', message: 'Post is saved', data:@post}, status: :ok
        else
          render json: {status: 'Error', message: 'Post is not saved', data:@post.errors}, status: :unprocessable_entity
        end
      end

      def update
        @post = Post.find(params[:id])

        if @post.update_attributes(post_params)
          render json: {status: 'SUCCESS', message: 'Post is updated', data:@post}, status: :ok
        else
          render json: {status: 'Error', message: 'Post is not updated', data:@post.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @post = Post.find(params[:id])
        @post.destroy

        render json: {status: 'SUCCESS', message: 'Post successfully deleted', data:@post}, status: :ok
      end

      private
        def post_params
          params.permit(:title, :body, :user_id)
        end
    end
  end
end
