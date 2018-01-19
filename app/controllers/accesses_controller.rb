class AccessesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:access_request]

  def access_request
    @subscription = Access.new(access_request_params)
    authorize @subscription
    if @subscription.save
      redirect_to root_path, :flash => { :notice => "We registered your access request for #{@subscription.email}. We will get back to you very soon." }
    elsif @subscription.errors.messages[:email][0] == "is invalid"
      redirect_to access_path, :flash => { :alert => "Invalid email format." }
    else
      redirect_to access_path, :flash => { :alert => "We encountered a problem to proceed your access request." }
    end
  end

  private

  def access_request_params
    params.permit(:email)
  end
end
