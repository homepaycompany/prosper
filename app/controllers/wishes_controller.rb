class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
  end

  def create
    raise
    @flat = Flat.find(params[:flat_id])
    @wish = Wish.new(user: current_user, flat: @flat)
    @wish.save
  end

  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    redirect_to wishes_path
  end
end

