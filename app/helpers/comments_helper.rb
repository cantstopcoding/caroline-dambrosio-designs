module CommentsHelper
    def display_edit_or_delete
        if @comment.user == current_user
            link_to("Update Comment", edit_comment_path(@comment)) +
            button_to("Delete Comment", comment_path(@comment), :method => "delete")
        end
    end
end