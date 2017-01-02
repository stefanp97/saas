class Users::RegistrationsController < Devise::RegistrationsController
  # Extend devise behavior ->
  # Pro Users signing up with pro {plan id:2}
  # Save with Stripe function
  #Other whise sign up with basic devise function
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end
