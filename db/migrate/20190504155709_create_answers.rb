class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
