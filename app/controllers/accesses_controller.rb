class AccessesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:access_request]

  def access_request
    @access = Access.new(access_request_params)
    authorize @access
    if @access.save
      redirect_to root_path, :flash => { :notice => "Vous êtes bien enregistrés sur notre liste d'attente. Nous vous enverons rapidement un email à #{@access.email}." }
    else
      redirect_to access_path, :flash => { :alert => "Nous avons rencontré un problème lors de votre inscription." }
    end
  end

  private

  def access_request_params
    params.permit(:first_name, :last_name, :email)
  end
end
