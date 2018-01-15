class WishesController < ApplicationController

  def wishlist
    @wishes = policy_scope(Wish)
  end
end
