class RemoveReplyCommentFromComment < ActiveRecord::Migration[6.0]
  def change

    remove_column :comments, :reply_comment, :int
  end
end
