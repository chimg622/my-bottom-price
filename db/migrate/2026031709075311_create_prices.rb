class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.integer :price,             null: false
      t.integer :quantity,          null: false
      t.integer :unit,              null: false, default: 0
      t.decimal :unit_price,        precision: 10, scale: 2, null: false
      t.references :user,           null: false, foreign_key: true
      t.references :shop,           null: false, foreign_key: true
      t.references :item,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
