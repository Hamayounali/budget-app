class CreateGroupDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :group_deals do |t|
      t.integer :deal_id
      t.integer :group_id
      t.index ["deal_id"], name: "index_group_deals_on_deal_id"
      t.index ["group_id"], name: "index_group_deals_on_group_id"

      t.timestamps
    end
  end
end
