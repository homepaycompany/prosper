class WishesController < ApplicationController
  before_action :set_flats, only: [:index]

  def index
    # Select flats which have been added to the wishlist
    @wishes = policy_scope(Wish)
    @flat_urls = @wishes.map { |wish| wish["flat_url"] }
    @wished_flats = @flats.select { |flat| @flat_urls.include?(flat["url"]) }

    # Define markers for the map
    @markers = @wished_flats.map do |flat|
      {
        lat: flat["latitude"],
        lng: flat["longitude"],
        infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat["title"] }) }
      }
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
    uri = URI("https://propertyhubprod.azurewebsites.net/api/RestApi?code=#{ENV['PROPERTY_HUB_API_KEY']}")
    Net::HTTP.start(uri.host, uri.port,
      :use_ssl => uri.scheme == 'https') do |http|
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = { "City":"Marseille","ZipCode":"13002","DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
      res = http.request req
      @flats = JSON.parse(res.body).sort_by { |flat| -flat["date"]  }

      # Add an id to the different flats obtained from the API
      i = 0
      @flats.map do |flat|
        i += 1
        flat["id"] = i
      end
    end
  end
end
