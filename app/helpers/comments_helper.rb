module CommentsHelper
  def display_edit_or_delete
    if @comment.user == current_user
      link_to("Update Comment", edit_comment_path(@comment)) +
      button_to("Delete Comment", comment_path(@comment), :method => "delete")
    end
  end
end

def hidden_field_or_display_collection_select
  if !@comment.item
    select_tag "comment[item_id]", options_from_collection_for_select(Item.all, :id, :name)
  else
    hidden_field_tag "comment[item_id]", @comment.item_id
  end
end
