class CreateArticleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      t.string :tag_name

      t.timestamps
    end
  end
end
