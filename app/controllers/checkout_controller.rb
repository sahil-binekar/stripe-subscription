class CheckoutController < ApplicationController
  def create
    post = Post.find(params[:id])
    price_id = params[:price_id]
    @session = Stripe::Checkout::Session.create({
    payment_method_types: ['card'],
    customer: current_user.customer_id,
    line_items: [{
        # For metered billing, do not pass quantity
        email: params[:email],
        quantity: 1,
        price: price_id,
    }],
    mode: 'subscription',
    success_url: root_url,
    cancel_url: root_url
    })
    respond_to do |format|
      format.js
      format.html { redirect_to root_url, notice: "You are successfully subscribed!" }
    end
  end

  def update
  end

  def destroy
    # binding.pry
    @request = Stripe::Subscription.delete(current_user.subscriptions.find_by(user_id: current_user.id).plan_id)
    current_user.subscriptions.find_by(user_id: current_user.id).destroy
    respond_to do |format|
      sleep 1
      format.html { redirect_to root_url, notice: "You are successfully unsubscribed!" }
    end
  end
end