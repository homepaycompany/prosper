class FlatsCleanJob < ApplicationJob
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
    @flats = []
    zipcodes.each do |zipcode|
    # zipcodes.each do |zipcode|
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = { "City": City.where("zip_code like ?", "%#{zipcode}%").first.name,"ZipCode": zipcode,"DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
        res = http.request req
        answer = JSON.parse(res.body)
        @bids = answer["bids"]
        @city_id = City.where("zip_code like ?", "%#{zipcode}%").first.id

        # Add average value for each bid
        @bids.each do |bid|
          if Flat.where(flat_id: bid['id']).length > 0
            bid["city_id"] = @city_id
            bid["avg_price"] = answer["average"] ? answer["average"] : 0
            bid["avg_surface"] = answer["surfaceAverage"] ? answer["surfaceAverage"] : 0
            bid["avg_plot_surface"] = answer["plotsurfaceAverage"] ? answer["plotsurfaceAverage"] : 0
            bid["avg_rooms"] = answer["roomsAverage"] ? answer["roomsAverage"] : 0
            bid["avg_date"] = answer["days"] ? answer["days"] : 0
            if bid["price"] && bid["surface"]
              bid["price_per_sq_m"] = bid["price"].to_f / bid["surface"]
              # Internal rate return depending on reselling price and notarial costs
              bid["return"] = ((bid["avg_price"] - bid["price_per_sq_m"] - bid["avg_price"] * 0.025 - bid["price_per_sq_m"] * 0.2 * 0.03).to_f / bid["price_per_sq_m"])
            else
              bid["price_per_sq_m"] = 0
              bid["return"] = 0
            end
          end
          @flats << bid
        end
      end
    end
    return @flats
  end

  # Task to clean the database with a POST request to API Property Hub Staging
  def perform
    @flats = Flat.all
    @zipcodes = set_zipcodes
    @bids = API_request(@zipcodes)
    @flats.each do |flat|
      if @bids.select{|bid| bid['url'] == flat['url']}.count == 0
        flat.destroy
      end
    end
  end
end
