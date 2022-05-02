class AddFieldsToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :daily_price_id, :string
    add_column :posts, :weekly_price_id, :string
    rename_column :posts, :price_id, :monthly_price_id
  end
end
