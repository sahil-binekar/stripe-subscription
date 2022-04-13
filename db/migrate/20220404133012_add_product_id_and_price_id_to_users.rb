class AddProductIdAndPriceIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :product_id, :string, default: nil
    add_column :users, :price_id, :string, default: nil
  end
end
