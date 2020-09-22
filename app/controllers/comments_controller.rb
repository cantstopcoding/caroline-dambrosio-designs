class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action -> {set_object(Comment)}, only: [:show, :edit, :update, :destroy]
    before_action -> {redirect_if_not_object_user_for(Comment)}, only: [:edit, :update, :destroy]
    
    def index
      if params[:item_id] && @item = Item.find_by(id: params[:item_id])
        @comments = @item.comments.order_recent_date 
      else
        @error = "Item doesn't exist" if params[:item_id] # user @error because flash persists through 1 redirect
        @comments = Comment.all.order_recent_date 
      end
    end
    
    def new
      if params[:item_id] && @item = Item.find_by(id: params[:item_id])
        @comment = @item.comments.build
      else
        @error = "Item doesn't exist" if params[:item_id] 
        @comment = Comment.new 
      end
    end

    def create 
      @comment = current_user.comments.build(comment_params)
      @item = Item.find_by(id: params[:comment][:item_id])
      
      if @comment.save
          redirect_to item_comments_path(@item)
      else
          render :new
      end
    end
    
    def show 
    end

    def edit
    end

    def update
      if @comment.update(comment_params)
        redirect_to comment_path(@comment)
      else
        render :edit
      end
    end

    def destroy
      @comment = Comment.find_by(id: params[:id])
      @item = @comment.item 
      @comment.destroy 
      flash[:message] = "Comment deleted"
      redirect_to item_path(@item)
  end

    private

  def comment_params
    params.require(:comment).permit(:content, :item_id)
  end
end
