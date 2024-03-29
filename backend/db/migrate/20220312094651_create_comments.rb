class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.string :category, null: false
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
