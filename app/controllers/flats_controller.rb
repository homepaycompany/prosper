require 'net/http'
require 'uri'

class FlatsController < ApplicationController
  before_action :set_flat, :set_chart_data, only: [:show]
  before_action :set_flats, :sort_flats, :filter_flats, only: [:index]
  before_action :clean_params, only: [:show, :index]
  skip_after_action :verify_authorized, only: :show

  def index
    # Current page selected by the user
    @current_page = params["pg"].to_i

    # Select n first elements according to pagination
    @page_number = (@flats.length / 10.to_f).ceil
    if @current_page.nil?
      @selected_flats = @flats.first(10)
    else
      @selected_flats = @flats[(([@current_page, 1].max-1) * 10 + 1)..([@current_page, 1].max * 10)]
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

  def show
    # Set flat as seen
    if Visit.where(user_id: current_user.id).where(flat_id: @flat.id).count == 0
      Visit.create(user_id: current_user.id, flat_id: @flat.id)
    end

    # Define flat marker for the map
    if @flat.latitude && @flat.longitude
      @marker = [{ lat: @flat.latitude, lng: @flat.longitude, infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: @flat }) } }]
    else
      @marker = []
    end
  end

  private

  def set_flats
    @flats = policy_scope(Flat.all).where("investment_return > ?", -0.7).where("investment_return < ?", 0.7)
  end

  # Sort flats according to the criteria chosen by the visitor
  def sort_flats
    @sort_type = params["sort"]
    if @sort_type == "a-price"
      @flats = @flats.order(price: :asc)
    elsif @sort_type == "d-price"
      @flats = @flats.order(price: :desc)
    elsif @sort_type == "a-surface"
      @flats = @flats.order(surface: :asc)
    elsif @sort_type == "d-surface"
      @flats = @flats.order(surface: :desc)
    elsif @sort_type == "a-return"
      @flats = @flats.order(investment_return: :asc)
    elsif @sort_type == "d-return"
      @flats = @flats.order(investment_return: :desc)
    elsif @sort_type == "a-date"
      @flats = @flats.order(date: :asc)
    else
      @flats = @flats.order(date: :desc)
    end
  end

  # Filter flats according to the criteria chosen by the visitor
  def filter_flats
    @price_min = params['price_min'].to_i
    @price_max = params['price_max'].to_i
    @return_min = params['return_min'].to_f / 100
    @return_max = params['return_max'].to_f / 100
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

  def set_flat
    set_flats
    @flat = @flats.select { |flat| flat.id == params[:id].to_i }.first
  end

  # Clean unused filters
  def clean_params
    params.reject{|_,v| v == ""}
  end

  # Define points for scatter char
  def set_chart_data
    # Determine data for the flats presented in charts
    @flats_data_hash = {name: "flats", data: []}
    @flats_data_hash_2 = {name: "flats", data: []}
    @flats.reject{|flat| flat.id == @flat.id}.each do |flat|
      if @flats_data_hash[:data].size <= 100 && flat.price && flat.price < 1000000 && flat.price > 0 && flat.surface && flat.surface < 500 && flat.surface > 0
        @flats_data_hash[:data] << [flat.price, flat.surface]
      end
      if @flats_data_hash_2[:data].size <= 100 && flat.price && flat.price < 1000000 && flat.price > 0 && flat.surface < 500 && flat.surface > 0
        @flats_data_hash_2[:data] << [flat.price / flat.surface, flat.surface]
      end
    end

    # Determine data for selected flats presented in charts
    @flat_data_hash = {name: "flat", data: [[@flat.price, @flat.surface]]}
    @flat_data_hash_2 = {name: "flat", data: [[@flat.price / @flat.surface, @flat.surface]]} if @flat.surface && @flat.surface > 0

    # Data for the first chart (price, size)
    @chart_data = [@flats_data_hash, @flat_data_hash]
    @chart_2_data = [@flats_data_hash_2, @flat_data_hash_2]
  end
end
