class ItemsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :redirect_if_not_item_author, only: [:edit, :update, :destroy]

    def new
        @item = Item.new
        @item.build_category 
    end

    def create
        @item = current_user.items.build(item_params)
        if @item.save
            redirect_to user_items_path(current_user)
        else
            render :new
        end
    end

    def index 
        if params[:user_id] && @user = User.find_by(id: params[:user_id])
            @items = @user.items.most_comments  
        else
            @error = "User doesn't exist" if params[:user_id] # user @error because flash persists through 1 redirect
            @items = Item.most_comments.includeds(:category, :user) 
        end
        @items = @items.filter(params[:item][:category_id]) if params[:item] && params[:item][:category_id] != ""
    end

    def show
        @comments = @item.comments.order_recent_date
    end

    def edit
        @item.build_category if !@item.category
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
        params.require(:item).permit(:name, :image, :price, :description, :user_id, :category_id, category_attributes: [:name]) 
    end

    def set_item
        @item = Item.find_by(id: params[:id])
        if !@item
            flash[:message] = "Item was not found"
            redirect_to items_path
        end
    end

    def redirect_if_not_item_author
        if @item.user != current_user
            flash[:message] = "You are not authorized to edit or delete that item!"
            redirect_to user_path(current_user) 
        end
    end
end
