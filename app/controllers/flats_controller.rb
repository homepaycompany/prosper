class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]

  def index
    @flats = policy_scope(Flat.all)
  end

  def show
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end
end
