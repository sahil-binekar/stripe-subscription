class AddPriceIdToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :price_id, :string, default: nil
  end
end
