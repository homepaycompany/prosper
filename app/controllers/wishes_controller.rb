class WishesController < ApplicationController
  before_action :set_flats, only: [:index]
  before_action :set_flats, :sort_flats, :filter_flats, only: [:index]
  before_action :clean_params, only: [:index]

  def index
    # Select flats which have been added to the wishlist
    @wishes = policy_scope(Wish)
    @flat_urls = @wishes.map { |wish| wish["flat_url"] }
    @wished_flats = @flats.select { |flat| @flat_urls.include?(flat["url"]) }

    # Select n first elements according to pagination
    @current_page = params["pg"].to_i
    @page_number = (@wished_flats.length / 10.to_f).ceil
    if @current_page.nil?
      @selected_flats = @wished_flats.first(10)
    else
      @selected_flats = @wished_flats[@current_page..(@current_page + 10)]
    end


    # Define markers for the map
    if @selected_flats && @selected_flats.size > 0
      @markers = @selected_flats.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
      end
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

  private

  def set_flats
    @flats = policy_scope(Flat.all)
  end

  # Sort flats according to the criteria chosen by the visitor
  def sort_flats
    @sort_type = params["sort"]
    if @sort_type == "a-price"
      @flats.order("price ASC")
    elsif @sort_type == "d-price"
      @flats.order("price DSC")
    elsif @sort_type == "a-surface"
      @flats.order("surface ASC")
    elsif @sort_type == "d-surface"
      @flats.order("surface DSC")
    elsif @sort_type == "a-return"
      @flats.order("investment_return ASC")
    elsif @sort_type == "d-return"
      @flats.order("investment_return DSC")
    elsif @sort_type == "a-date"
      @flats.order("date ASC")
    else
      @flats.order("date DSC")
    end
  end

  # Filter flats according to the criteria chosen by the visitor
  def filter_flats
    @price_min = params['price_min'].to_i
    @price_max = params['price_max'].to_i
    @return_min = params['return_min'].to_i / 100
    @return_max = params['return_max'].to_i / 100
    @surface_min = params['surface_min'].to_i
    @surface_max = params['surface_max'].to_i
    if params['room_5'] == 1
      @room_nb = 5
    elsif params['room_4'] == 1
      @room_nb = 4
    elsif params['room_3'] == 1
      @room_nb = 3
    elsif params['room_2'] == 1
      @room_nb = 2
    else
      @room_nb = 0
    end

    @flats = @flats.where("price >= :price_min", price_min: @price_min) if @price_min > 0
    @flats = @flats.where("price <= :price_max", price_max: @price_max) if @price_max > 0
    @flats = @flats.where("investment_return >= :return_min", return_min: @return_min) if @return_min > 0
    @flats = @flats.where("investment_return <= :return_max", return_max: @return_max) if @return_max > 0
    @flats = @flats.where("surface >= :surface_min", surface_min: @surface_min) if @surface_min > 0
    @flats = @flats.where("surface <= :surface_max", surface_max: @surface_max) if @surface_max > 0
    @flats = @flats.where("rooms <= :room_nb", room_nb: @room_nb) if @room_nb > 1
  end

  # Clean unused filters
  def clean_params
    params.reject{|_,v| v == ""}
  end
end
