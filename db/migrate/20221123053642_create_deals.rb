class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :name
      t.decimal :amount, default: "0.0", null: false
      t.integer :author_id
      t.index ["author_id"], name: "index_deals_on_author_id"

      t.timestamps
    end
  end
end
