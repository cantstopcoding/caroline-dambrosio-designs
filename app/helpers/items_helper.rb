module ItemsHelper
    def index_display_header
        if @user
            content_tag(:h1, "#{@user.username}'s Items")
        else 
            content_tag(:h2, "All Items")
        end
    end

    def display_items
        if @user.items.empty?
          tag.h2(link_to('No items yet - write a item here', new_item_path))
        else
          user = @user == current_user ? 'Your' : "#{@user.username}'s"
          content_tag(:h2, "#{user} #{pluralize(@user.items.count, 'item')}:")
        end
    end

    def display_edit_and_delete
        if @item.user == current_user
            link_to("Update Item", edit_item_path) +
            button_to("Delete Item", item_path(@item), :method => "delete")
        end
    end
end
