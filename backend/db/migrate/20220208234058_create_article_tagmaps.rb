class CreateArticleTagmaps < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tagmaps do |t|
      t.references :article, null: false, foreign_key: true
      t.references :article_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
