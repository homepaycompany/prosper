class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
    @flats = @wishes.map{ |wish| wish.flat }.reject{ |flat| flat.latitude.nil? }.reject{ |flat| flat.longitude.nil? }
    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat.title }) }
      }
    end
  end

  def create
    @wish = Wish.new(user: current_user, flat_url: params[:flat_url])
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

