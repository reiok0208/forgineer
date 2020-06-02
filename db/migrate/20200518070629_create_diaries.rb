class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false, :limit => 4294967295
      t.text :diary_image_id
      t.integer :impressions_count, default: 0

      t.timestamps
    end

    add_index :diaries, [:title]
  end
end
