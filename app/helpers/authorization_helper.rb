module AuthorizationHelper
  # Redirects if user is not admin
  def admin_filter
    redirect_to root_path unless current_user.admin
  end

  # Redirects if user is not subscribed or is not admin
  def subscribed_filter
    redirect_to root_path unless current_user.subscribed || current_user.admin
  end
end
