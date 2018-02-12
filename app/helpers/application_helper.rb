module ApplicationHelper
  def active_class(link_path)
    active = current_page?(link_path) ? "active" : ""
  end

  def in_wishlist?(flat)
    Wish.all.where(flat_url: flat["url"], user: current_user).count >= 1
  end

  def price_per_squared_meter(flat)
    flat["price"] / flat["surface"] if flat["surface"] > 0
  end
end
