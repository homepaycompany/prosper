require 'net/http'
require 'uri'

class FlatsController < ApplicationController
  before_action :set_flat, only: [:show]

  def index
    uri = URI('https://testprop.azurewebsites.net/api/LeboncoinApi?code=3O49D3iZBLQvVAhpRq/UYbFBjGWVvaRzwYp94rkSljL4TjpCwVDu4w==')
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = { "City": "Paris", "ZipCode": "75001", "DateFrom": "0001-01-01T00:00:00", "DateTo": "9999-12-31T23:59:59.9999999" }.to_json
      res = http.request req
      @flats = JSON.parse(res.body)
    end

    @flats = policy_scope(Flat.all).where.not(latitude: nil, longitude: nil)

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat.title }) }
      }
    end
  end

  def show
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
    authorize @flat
  end
end
