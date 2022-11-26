class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :icon
      t.integer :author_id
      t.decimal :total_amount, default: "0.0", null: false
      t.index ["author_id"], name: "index_groups_on_author_id"

      t.timestamps
    end
  end
end
