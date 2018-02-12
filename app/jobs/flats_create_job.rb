class FlatsCreateJob < ApplicationJob
  queue_as :default

  # Get zip codes of available cities
  def set_zipcodes
    @zipcodes = []
    City.all.each{|city| @zipcodes << city.zip_code.split(', ')}
    @zipcodes.flatten!
  end

  # For each zipcode, perform a POST request to API Property Hub Staging
  def API_request(zipcodes)
    uri = URI("https://propertyhubstaging.azurewebsites.net/api/JsonApi?code=#{ENV['PROPERTY_HUB_API_KEY']}")
    @flats_to_create = []
    zipcodes.each do |zipcode|
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = { "City": City.where("zip_code like ?", "%#{zipcode}%").first.name,"ZipCode": zipcode,"DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
        res = http.request req
        @answer = JSON.parse(res.body)
        @bids = @answer["bids"]
        @city_id = City.where("zip_code like ?", "%#{zipcode}%").first.id

        # Add additional information if the bid does not exist in the database
        @bids.each do |bid|
          if Flat.where(flat_id: bid['id']).length == 0
            bid["city_id"] = @city_id
            bid["avg_price"] = @answer["average"] ? @answer["average"] : 0
            bid["avg_surface"] = @answer["surfaceAverage"] ? @answer["surfaceAverage"] : 0
            bid["avg_plot_surface"] = @answer["plotsurfaceAverage"] ? @answer["plotsurfaceAverage"] : 0
            bid["avg_rooms"] = @answer["roomsAverage"] ? @answer["roomsAverage"] : 0
            bid["avg_date"] = @answer["days"] ? @answer["days"] : 0
            if bid["price"] && bid["surface"]
              bid["price_per_sq_m"] = bid["price"].to_f / bid["surface"]
              # Internal rate return depending on reselling price and notarial costs
              bid["return"] = ((bid["avg_price"] - bid["price_per_sq_m"] - bid["avg_price"] * 0.025 - bid["avg_price"] * 0.2 * 0.03).to_f / bid["price_per_sq_m"])
            else
              bid["price_per_sq_m"] = 0
              bid["return"] = 0
            end
            @flats_to_create << bid
          end
        end
      end
    end
    return @flats_to_create
  end

  # Create flat in database
  def create_flat(flat)
    flat = Flat.create(flat_id: flat['id'],
                origin: flat['origin'],
                date: DateTime.strptime(flat["date"]),
                url: flat['url'],
                title: flat['title'],
                description: flat['description'],
                price: flat['price'].to_i,
                rooms: flat['rooms'].to_i,
                surface: flat['surface'].to_i,
                plotsurface: flat['plotSurface'].to_i,
                city_id: flat['city_id'],
                zipcode: flat['zipCode'],
                latitude: flat['latitude'].to_f,
                longitude: flat['longitude'].to_f,
                thumbs: flat['thumbs'],
                images: flat['images'],
                propertytype: flat['propertyType'],
                pricehistory: flat['priceHistory'],
                avg_price: flat['avg_price'].to_f,
                avg_surface: flat['avg_surface'].to_f,
                avg_plotsurface: flat['avg_plotsurface'].to_f,
                avg_rooms: flat['avg_rooms'].to_f,
                avg_date: flat['avg_date'].to_f,
                investment_return: flat['return'].to_f)
  end

  # Task to update the database with a POST request to API Property Hub Staging
  def perform
    @zipcodes = set_zipcodes
    @flats_to_create = API_request(@zipcodes)

    # Create flats in database only if the API returns results
    if @flats_to_create && (@flats_to_create.size > 0)
      @flats_to_create.each{ |flat| create_flat(flat)}
    end
  end
end
