class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
