class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @wish = Wish.new(user: current_user, flat: @flat)
    authorize @wish

    if @wish.save
      respond_to do |format|
        format.html { redirect_to redirect_back fallback_location: root_path }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @wish = Wish.find(params[:id])
    authorize @wish
    @wish.destroy
    redirect_back fallback_location: root_path
  end
end

