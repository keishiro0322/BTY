class RemoveParentIdFromComment < ActiveRecord::Migration[6.0]
  def change

    remove_column :comments, :parent_id, :integer
  end
end
