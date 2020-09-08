class ItemsController < ApplicationController
    before_action :redirect_if_not_logged_in
    
    def index
      @items = Item.all 
    end
    
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
    
    def show 
      @item = Item.find_by(id: params[:id])
    end

    def edit
      @item = Item.find_by(id: params[:id])
    end

    def update
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render :edit
      end
    end

    private

  def item_params
    params.require(:item).permit(:name, :image, :price, :description, :post_id)
  end
end
