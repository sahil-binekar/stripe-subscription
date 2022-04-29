module PostsHelper

    def admin?
        current_user&.admin == true ? true : false
    end

    def subscribed?
        current_user&.subscribed == true ? true : false
    end

    def permission?(post)
        binding.pry
        post_plan = post.product_id
        subs_plan = Subscription.where(user_id: current_user.id, plan_id: post_plan)
        post_plan == subs_plan.pluck(:plan_id).join ? true : false
    end

    def subscription_present?
        current_user&.subscriptions.present? ? true : false
    end
end
