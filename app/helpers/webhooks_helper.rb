module WebhooksHelper
  def info_message(msg,code)
    if code == 200
      flash.now[:notice] = "Info: #{msg}, Payment Success!"
    elsif code == 400
      flash.now[:notice] = "Error: #{msg} Something went wrong, try again!"
    elsif code == 500
      flash.now[:notice] = "Server error from service provider!"
    end
  end

  def notic_message(msg)
    binding.pry
  flash[:notice] = "Payment for #{number_to_currency(msg/100)} "
  end
end