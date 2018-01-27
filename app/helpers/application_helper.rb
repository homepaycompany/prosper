module ApplicationHelper
  def active_class(link_path)
    active = current_page?(link_path) ? "active" : ""
  end

  def in_wishlist?(flat, user)
    Wish.all.where(flat_url: flat["url"], user: user).count >= 1
  end
end
