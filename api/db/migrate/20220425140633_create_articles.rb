class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :users, null: false, foreign_key: true
      t.string :title, null: false, limit: 30
      t.text :content, null: false
      t.timestamps
    end
  end
end