class AddProductIdToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :product_id, :string, default: nil
  end
end
