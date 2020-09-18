class ItemsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_item, only: [:show, :edit, :update]

    def new
        @item = Item.new 
    end

    def create
        @item = current_user.items.build(item_params)
        if @item.save
            redirect_to items_path
        else
            render :new
        end
    end

    def index 
        if params[:user_id] && @user = User.find_by(id: params[:user_id])
            @items = @user.items.most_comments  
        else
            @error = "User doesn't exist" if params[:user_id] # user @error because flash persists through 1 redirect
            @items = Item.most_comments 
        end
    end

    def show
        @comments = @item.comments.order_recent_date
    end

    def edit
    end

    def update
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render :edit
      end
    end

    def destroy
        @item = Item.find_by_id(params[:id])
        @item.destroy 
        flash[:message] = "#{@item.name} deleted"
        redirect_to user_items_path(current_user)
    end

    private

    def item_params
        params.require(:item).permit(:name, :image, :price, :description, :user_id) 
    end

    def set_item
        @item = Item.find_by(id: params[:id])
        if !@item
            flash[:message] = "Item was not found"
            redirect_to items_path
        end
    end
end
