class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user
      t.string :title
      t.text :content
      t.string :image

      t.timestamps
    end

    add_index :articles, [:title, :user_id], unique: true
  end
end
