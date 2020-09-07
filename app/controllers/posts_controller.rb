class PostsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
        @post = Post.new 
    end

    def create
        binding.pry
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to posts_path
        else
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
      end
end
