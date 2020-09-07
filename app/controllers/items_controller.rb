class ItemsController < ApplicationController
    before_action :redirect_if_not_logged_in
    
    def index
    end
    
    def new
    end

    private

  def item_params
    params.require(:item).permit(:name, :image, :price, :description, :post_id)
  end
end
