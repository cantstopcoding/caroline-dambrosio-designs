class ItemsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action -> {set_object(Item)}, only: [:show, :edit, :update, :destroy]
    before_action -> {redirect_if_not_object_user_for(Item)}, only: [:edit, :update, :destroy]

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
            @items = Item.most_comments.includes(:category, :user) 
            @display_user = true
            # by: <%= link_to item.user.username, user_path(item.user) %> 
        end
        @items = @items.search(params[:q].downcase) if params[:q] && !params[:q].empty?
        @items = @items.filter_category(params[:item][:category_id]) if params[:item] && params[:item][:category_id] != ""
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
        @item.destroy 
        flash[:message] = "#{@item.name} deleted"
        redirect_to user_items_path(current_user)
    end

    private

    def item_params
        params.require(:item).permit(:name, :image_url, :price, :description, :user_id, :category_id, category_attributes: [:name]) 
    end
end