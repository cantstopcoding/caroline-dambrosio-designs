class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :image
      t.float :price
      t.text :description
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
