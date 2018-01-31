require 'net/http'
require 'uri'

class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]
  before_action :set_flats, only: [:index]
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: :show

  def index
    # Select n first elements according to pagination
    @current_page = params["pg"].to_i
    @page_number = (@flats.length / 10.to_f).ceil
    @sort_type = params["sort"]
    if @current_page.nil?
      @selected_flats = @flats.first(10)
    else
      @selected_flats = @flats[(@current_page * 10 + 1)..(@current_page * 10 + 10)]
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

      # Sort flats according to the criteria chosen by the visitor
      if @sort_type == "a-price"
        @flats = JSON.parse(res.body).sort_by { |flat| flat["price"].to_f }
      elsif @sort_type == "d-price"
        @flats = JSON.parse(res.body).sort_by { |flat| -flat["price"].to_f }
      elsif @sort_type == "a-surface"
        @flats = JSON.parse(res.body).sort_by { |flat| flat["surface"].to_f }
      elsif @sort_type == "d-surface"
        @flats = JSON.parse(res.body).sort_by { |flat| -flat["surface"].to_f }
      elsif @sort_type == "a-return"
        @flats = JSON.parse(res.body).sort_by { |flat| -DateTime.strptime(flat["date"]).to_f }
      elsif @sort_type == "d-return"
        @flats = JSON.parse(res.body).sort_by { |flat| -DateTime.strptime(flat["date"]).to_f }
      elsif @sort_type == "a-date"
        @flats = JSON.parse(res.body).sort_by { |flat| DateTime.strptime(flat["date"]).to_f }
      else
        @flats = JSON.parse(res.body).sort_by { |flat| -DateTime.strptime(flat["date"]).to_f }
      end

      # Add an id to the different flats obtained from the API
      i = 0
      @flats.map do |flat|
        i += 1
        flat["id"] = i
      end
    end
  end

  def set_flat
    set_flats
    @flat = @flats.select { |flat| flat["url"] == params[:flat_url] }.first
  end
end
