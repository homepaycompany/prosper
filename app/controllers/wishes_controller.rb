class WishesController < ApplicationController
  def index
    @wishes = policy_scope(Wish)
  end
end
