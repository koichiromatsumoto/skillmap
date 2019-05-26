class CreateLayers < ActiveRecord::Migration[5.2]
  def change
    create_table :layers do |t|
      t.integer :category1_id
      t.integer :category2_id
      t.integer :category3_id
      t.integer :category4_id
      t.integer :category5_id
      t.integer :category6_id
      t.integer :row_order
      t.integer :user_id

      t.timestamps
    end
  end
end
