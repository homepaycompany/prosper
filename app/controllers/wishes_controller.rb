class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @wish = Wish.new(user: current_user, flat: @flat)
    authorize @wish
    @wish.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @wish = Wish.find(params[:id])
    authorize @wish
    @wish.destroy
    redirect_back fallback_location: root_path
  end
end

