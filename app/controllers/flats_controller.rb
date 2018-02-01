require 'net/http'
require 'uri'

class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]
  before_action :set_flats, :sort_flats, :filter_flats, only: [:index]
  before_action :clean_params, only: [:show, :index]
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: :show

  def index
    # Current page selected by the user
    @current_page = params["pg"].to_i

    # Select n first elements according to pagination
    @page_number = (@flats.length / 10.to_f).ceil
    if @current_page.nil?
      @selected_flats = @flats.first(10)
    else
      @selected_flats = @flats[((@current_page-1) * 10 + 1)..(@current_page * 10)]
    end

    # Define markers for the map
    @markers = @selected_flats.map do |flat|
      {
        lat: flat["latitude"],
        lng: flat["longitude"],
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat["title"] }) }
      }
    end
  end

  def show
    # Define markers for the map
    @markers = @flats.select { |flat| flat["url"] == params[:flat_url] }.map do |flat|
      {
        lat: flat["latitude"],
        lng: flat["longitude"],
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat["title"] }) }
      }
    end
  end

  private

  def set_flats
    uri = URI("https://propertyhubprod.azurewebsites.net/api/RestApi?code=#{ENV['PROPERTY_HUB_API_KEY']}")
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = { "City": current_user.city,"ZipCode": current_user.zip_code,"DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
      res = http.request req
      @flats = JSON.parse(res.body)

      # Add an id to the different flats obtained from the API
      i = 0
      @flats.map do |flat|
        i += 1
        flat["id"] = i
      end
    end
  end

  # Sort flats according to the criteria chosen by the visitor
  def sort_flats
    @sort_type = params["sort"]
    if @sort_type == "a-price"
      @flats.sort_by! { |flat| flat["price"].to_f }
    elsif @sort_type == "d-price"
      @flats.sort_by! { |flat| -flat["price"].to_f }
    elsif @sort_type == "a-surface"
      @flats.sort_by! { |flat| flat["surface"].to_f }
    elsif @sort_type == "d-surface"
      @flats.sort_by! { |flat| -flat["surface"].to_f }
    elsif @sort_type == "a-return"
      @flats.sort_by! { |flat| -DateTime.strptime(flat["date"]).to_f }
    elsif @sort_type == "d-return"
      @flats.sort_by! { |flat| -DateTime.strptime(flat["date"]).to_f }
    elsif @sort_type == "a-date"
      @flats.sort_by! { |flat| DateTime.strptime(flat["date"]).to_f }
    else
      @flats.sort_by { |flat| -DateTime.strptime(flat["date"]).to_f }
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

    @flats.select!{|flat| flat['price'] >= @price_min if flat['price']} if @price_min > 0
    @flats.select!{|flat| flat['price'] <= @price_max if flat['price']} if @price_max > 0
    # @flats.select!{|flat| flat['return'] >= @return_min if flat['return']} if @return_min > 0
    # @flats.select!{|flat| flat['return'] <= @return_max if flat['return']} if @return_max > 0
    @flats.select!{|flat| flat['surface'] >= @surface_min if flat['surface']} if @surface_min > 0
    @flats.select!{|flat| flat['surface'] <= @surface_max if flat['surface']} if @surface_max > 0
    @flats.select!{|flat| flat['rooms'] >= @room_nb if flat['rooms']} if @room_nb > 1
  end

  def set_flat
    set_flats
    @flat = @flats.select { |flat| flat["url"] == params[:flat_url] }.first
  end

  # Clean unused filters
  def clean_params
    params.reject{|_,v| v == ""}
  end
end
