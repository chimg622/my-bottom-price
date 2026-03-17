class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name,               null: false
      t.integer :unit,              null: false, default: 0
      t.references :user,           null: false, foreign_key: true
      t.references :category,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
