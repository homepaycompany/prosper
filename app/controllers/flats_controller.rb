class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]

  def index
    @flats = policy_scope(Flat.all).where.not(latitude: nil, longitude: nil)

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat.title }) }
      }
    end
  end

  def show
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end
end
