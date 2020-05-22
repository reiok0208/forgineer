class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.string :body, null: false
      t.text :diary_image_id

      t.timestamps
    end

    add_index :diaries, [:id, :title, :body]
  end
end
