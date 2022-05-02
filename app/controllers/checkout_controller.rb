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
      success_url: "https://ac77-59-95-101-113.ngrok.io/checkout/succeed",
      # success_url:  root_url,
      cancel_url: "https://ac77-59-95-101-113.ngrok.io/checkout/cancelled"
      # cancel_url: root_url
      })
    respond_to do |format|
      format.js
      format.html { redirect_to checkout_succeed_path(message: "You are successfully subscribed!") }
    end
  end

  def show
  end

  def succeed
    @user = current_user.name
    @message = params[:message]
  end

  def subscription_end(data)
    redirect_to checkout_success_path(message: data)
    # @user = current_user
  end

  def cancelled
    # binding.pry
    @user = current_user.name
    @message = params[:message]
  end

  def destroy
    # binding.pry
    @request = Stripe::Subscription.delete(current_user.subscriptions.find_by(user_id: current_user.id).subs_id)
    Subscription.where(user_id: current_user.id, plan_id: params[:plan_id]).destroy_all
    respond_to do |format|
      sleep 1
      format.html { redirect_to checkout_cancelled_path(message: "You are successfully unsubscribed!") }
      # format.html { redirect_to webhooks_failed_path(user: current_user.name) }
    end
  end
end
