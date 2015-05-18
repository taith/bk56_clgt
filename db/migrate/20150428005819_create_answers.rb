class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question,:user
      t.string :title
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end
end