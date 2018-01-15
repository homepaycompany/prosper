class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]

  def index
    @flats = policy_scope(Flat)
  end

  def show

  end

  def wishlist

  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end
end
