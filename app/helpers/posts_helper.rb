module PostsHelper

    def admin?
        current_user&.admin == true ? true : false
    end

    def subscribed?
        current_user&.subscribed == true ? true : false
    end

    def subscription_present?
        current_user&.subscriptions.present? ? true : false
    end
end
