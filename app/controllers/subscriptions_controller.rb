class SubscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:subscribe]

  def subscribe
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to root_path, :flash => { :notice => "#{@subscription.email} will now received our newsletter. Stay tuned." }
    elsif Subscription.where(subscription_params).size > 0
      redirect_to root_path, :flash => { :alert => "#{@subscription.email} has already subscribed to our newsletter." }
    elsif @subscription.errors.messages[:email][0] == "is invalid"
      redirect_to root_path, :flash => { :alert => "Invalid email format." }
    else
      redirect_to root_path, :flash => { :alert => "We encountered a problem to sign you up in our newsletter." }
    end
  end

  private

  def subscription_params
    params.permit(:email)
  end
end
