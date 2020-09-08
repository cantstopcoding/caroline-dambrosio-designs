class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in
    
    def index
      @comments = Comment.all 
    end
    
    def new
      @comment = Comment.new 
    end

    def create 
      @comment = current_user.comments.build(comment_params)
        if @comment.save
            redirect_to comments_path
        else
            render :new
        end
    end
    
    def show 
      @comment = Comment.find_by(id: params[:id])
    end

    def edit
      @comment = Comment.find_by(id: params[:id])
    end

    def update
      if @comment.update(comment_params)
        redirect_to comment_path(@comment)
      else
        render :edit
      end
    end

    private

  def comment_params
    params.require(:comment).permit(:name, :image, :price, :description, :post_id)
  end
end
