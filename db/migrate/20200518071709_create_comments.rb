class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :diary, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false, :limit => 65535

      t.timestamps
    end
  end
end
