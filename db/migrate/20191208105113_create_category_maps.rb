class CreateCategoryMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :category_maps do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
  end
end
