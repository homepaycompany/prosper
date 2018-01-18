class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
  end

  def create

  end

  def destroy

  end
end
