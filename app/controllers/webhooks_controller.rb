class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    response = response
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      #Invalide signature
      p 'Signature Error'
      p e
      return
    end
    #Handle the errors
    begin
      # Use Stripe's library to make requests...
      case event.type
      when 'customer.subscription.created'
        subscription_obj = event.data.object
        @user = User.find_by(customer_id: subscription_obj.customer)
        @user.update(product_id:  subscription_obj.plan.product, price_id: subscription_obj.plan.id)
        @subscription = Subscription.create(user_id: @user.id, plan_id: subscription_obj.id)
      when 'customer.subscription.updated'
        customer_obj = event.data.object
        @user = User.find_by(customer_id: customer_obj.customer)
        if customer_obj.status == "active"
          @user.update(subscribed: true)
        end
      when 'customer.subscription.deleted'
        customer_obj = event.data.object
        @user = User.find_by(customer_id: customer_obj.customer)
        @user.update(:subscribed=> false)
      when 'checkout.session.completed'
        payment_object = event.data.object # contains a Stripe::PaymentIntent
        puts "Payment for #{payment_object['amount_total']} succeeded."
      end
      # when 'checkout.session.completed'
      # when 'checkout.session.completed'
      # when 'checkout.session.completed'
      # when 'checkout.session.completed'
      # when 'checkout.session.completed'
    rescue Stripe::CardError => e
      # binding.pry
      # WebhooksHelper.info_message(e.message, e.http_status)
      # flash.now[:error] = "#{e.message}"
    rescue Stripe::RateLimitError => e
      # binding.pry
      # flash.now[:error] = e.message
    rescue Stripe::InvalidRequestError => e
      # binding.pry
      # flash.now[:error] = e.message
    rescue Stripe::AuthenticationError => e
      # binding.pry
      # flash.now[:error] = e.message
    rescue Stripe::APIConnectionError => e
      # binding.pry
      # flash.now[:error] = e.message
    rescue Stripe::StripeError => e
      # binding.pry
      # flash.now[:error] = e.message
    rescue => e
      # flash[:error] = "#{e.message}"
    end
    # render json: {message: 'success' }
  end
end