class CreateAnswerDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_details do |t|
      t.integer :answer_id
      t.integer :layer_id
      t.integer :score

      t.timestamps
    end
  end
end
