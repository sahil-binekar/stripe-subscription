class AddSubscriptionIdToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :subs_id, :string
  end
end
