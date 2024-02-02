class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.string :price
      t.string :quantity

      t.timestamps
    end
  end
end
