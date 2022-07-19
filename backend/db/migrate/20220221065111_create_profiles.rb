class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, index: { unique: true }, foreign_key: true
      t.string :status, null: false
      t.string :starting_age, null: false
      t.date :birth, null: false
      t.string :gender, null: false
      t.string :residence, null: false
      t.text :introduction
      t.string :hobby
      t.string :github
      t.string :twitter
      t.string :qiita
      t.string :wontedly
      t.string :technology_used
      t.integer :study_period
      t.string :study_method
      t.string :teaching_materials
      t.string :corporate_form
      t.string :company_size
      t.string :annual_income
      t.integer :entry
      t.integer :meet
      t.integer :accepted

      t.timestamps
    end
  end
end
