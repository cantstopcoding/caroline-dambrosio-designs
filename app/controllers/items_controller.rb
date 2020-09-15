class ItemsController < ApplicationController
    before_action :redirect_if_not_logged_in

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
        @item = Item.find_by_id(params[:id])
    end

    private

    def item_params
        params.require(:item).permit(:name, :image, :price, :description, :user_id) 
      end
end
