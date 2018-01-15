class FlatsController < ApplicationController
  def index
    @flats = policy_scope(Flat)
  end
end
