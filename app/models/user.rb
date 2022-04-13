class User < ApplicationRecord
  after_create :register_customer
  # after_create :register_admin
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :customers
  has_many :subscriptions
  private

  def register_customer
    request = Stripe::Customer.create({
      email: email
    })
    update_attribute :customer_id, request[:id]
    # binding.pry
    # Customer.create(customer_stripe_id: request[:id])
  end
end
