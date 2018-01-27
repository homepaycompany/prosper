require 'net/http'
require 'uri'

class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]
  before_action :set_flats, only: [:index]
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: :show

  def index
    # Define markers for the map
    @markers = @flats.map do |flat|
      {
        lat: flat["latitude"],
        lng: flat["longitude"],
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat["title"] }) }
      }
    end
  end

  def show
  end

  private

  def set_flats
    uri = URI("https://propertyhubprod.azurewebsites.net/api/RestApi?code=#{ENV['PROPERTY_HUB_API_KEY']}")
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = { "City":"Marseille","ZipCode":"13002","DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
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

  def set_flat
    set_flats
    @flat = @flats.select { |flat| flat["url"] == params[:flat_url] }.first
  end
end
