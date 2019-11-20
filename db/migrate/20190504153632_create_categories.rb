class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :name
      t.boolean :root, default: false

      t.timestamps
    end
  end
end
