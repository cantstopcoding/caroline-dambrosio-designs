class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in
    
    def index
      if params[:item_id] && @item = Item.find_by(id: params[:item_id])
        @comments = @item.comments 
      else
        @error = "Item doesn't exist" if params[:item_id] # user @error because flash persists through 1 redirect
        @comments = Comment.all 
      end
    end
    
    def new
      if params[:item_id] && @item = Item.find_by(id: params[:item_id])
        @comment = @item.comments.build
      else
        @error = "Item doesn't exist" if params[:item_id] # user @error because flash persists through 1 redirect
        @comment = Comment.new 
      end
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
    params.require(:comment).permit(:content, :item_id)
  end
end
