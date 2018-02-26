class FlatsCreateJob < ApplicationJob
  queue_as :default

  # Get zip codes of available cities
  def set_zipcodes
    @zipcodes = []
    City.all.each{|city| @zipcodes << city.zip_code.split(', ')}
    @zipcodes.flatten!
  end

  # Set average by area according to barometre.immobilier.notaires.fr
  def average_by_area
    areas = [{area: "Toulouse", average_price: 2580},
             {area: "Lalande, Toulouse", average_price: 2000},
             {area: "Les Izards, Toulouse", average_price: 1860},
             {area: "Croix Daurade, Toulouse", average_price: 2130},
             {area: "Barrière de Paris, Toulouse", average_price: 2190},
             {area: "Sept Deniers, Toulouse", average_price: 2620},
             {area: "Minimes, Toulouse", average_price: 2500},
             {area: "Bonnefoy, Toulouse", average_price: 2480},
             {area: "Roseraie, Toulouse", average_price: 2150},
             {area: "Juncasse, Toulouse", average_price: 2140},
             {area: "Chateau de l'Hers, Toulouse", average_price: 2270},
             {area: "La terrasse, Toulouse", average_price: 2500},
             {area: "Montaudran, Toulouse", average_price: 2350},
             {area: "Rangueil, Toulouse", average_price: 2710},
             {area: "Poupourville, Toulouse", average_price: 2800},
             {area: "La Fourguette, Toulouse", average_price: 1770},
             {area: "Saint Simon, Toulouse", average_price: 2190},
             {area: "Basso Cambo, Toulouse", average_price: 2250},
             {area: "Lardenne, Toulouse", average_price: 2600},
             {area: "Saint Martin du Touch, Toulouse", average_price: 2170},
             {area: "Purpan, Toulouse", average_price: 2150},
             {area: "Marengo, Toulouse", average_price: 2660},
             {area: "Guilhemery, Toulouse", average_price: 2650},
             {area: "Cote pavé, Toulouse", average_price: 2850},
             {area: "Pont des demoiseilles, Toulouse", average_price: 2600},
             {area: "Sauzelong - Rangueil, Toulouse", average_price: 2090},
             {area: "Jules Julien, Toulouse", average_price: 2760},
             {area: "Croix de pierre, Toulouse", average_price: 2070},
             {area: "La cépière, Toulouse", average_price: 2330},
             {area: "Casselardit, Toulouse", average_price: 2620},
             {area: "Amidonniers, Toulouse", average_price: 3000},
             {area: "Compans, Toulouse", average_price: 3310},
             {area: "Les chalets, Toulouse", average_price: 3800},
             {area: "Matabiau, Toulouse", average_price: 3620},
             {area: "Saint Aubin Dupuy, Toulouse", average_price: 4150},
             {area: "Le busca, Toulouse", average_price: 3350},
             {area: "Saint Agne, Toulouse", average_price: 2670},
             {area: "Arenes, Toulouse", average_price: 2480},
             {area: "Patte d'oie, Toulouse", average_price: 2780},
             {area: "Arnaud Bernard, Toulouse", average_price: 3570},
             {area: "Saint Georges, Toulouse", average_price: 4490},
             {area: "Saint Etienne, Toulouse", average_price: 4130},
             {area: "Carmes, Toulouse", average_price: 4230},
             {area: "Saint Cyprien, Toulouse", average_price: 3670},
             {area: "Capitole, Toulouse", average_price: 2690},
             {area: "Soupetard, Toulouse", average_price: 1830}]
    average_prices = areas.each{|a| a[:latitude] = Geocoder.coordinates(a[:area])[0]}.each{|a| a[:longitude] = Geocoder.coordinates(a[:area])[1]}
  end

  # Set average price for a specific flat depending on the closest area
  def set_average_price(bids, areas)
    bids.each do |bid|
      bid_lat = bid['latitude'].to_f
      bid_lng = bid['longitude'].to_f
      area = areas.min_by{|a| Geocoder::Calculations.distance_between([a[:longitude],a[:latitude]], [bid_lng, bid_lat])}
      bid["avg_price"] = area[:average_price]
    end
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

  # For each zipcode, perform a POST request to API Property Hub Staging
  def API_request(zipcodes)
    uri = URI("https://propertyhubstaging.azurewebsites.net/api/JsonApi?code=#{ENV['PROPERTY_HUB_API_KEY']}")
    zipcodes.each do |zipcode|
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = { "City": City.where("zip_code like ?", "%#{zipcode}%").first.name,"ZipCode": zipcode,"DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
        res = http.request req
        answer = JSON.parse(res.body)

        # Exclude bids for houses and whose surface is nil
        property_type = "apartment"
        @bids = answer["bids"].select{|bid| bid["propertyType"] == property_type}
        @bids.reject!{|bid| bid['surface'] == 0}

        # Exclude bids for flats with no latitude
        @bids.reject!{|bid| bid['latitude'] == 43.6041  && bid['longitude'] == 1.44067}

        # Exclude from bids, flats which have already been recorded
        urls = Flat.all.map{|flat| flat.url}
        @bids.reject!{|bid| urls.include?(bid['url'])}

        # Define the City of each flat
        @city_id = City.where("zip_code like ?", "%#{zipcode}%").first.id

        # Setup the averages by area
        areas = average_by_area

        # Add additional information if the bid does not exist in the database
        @bids.each do |bid|
          bid["city_id"] = @city_id
          bid["avg_surface"] = answer["surfaceAverage"] ? answer["surfaceAverage"] : 0
          bid["avg_plot_surface"] = answer["plotsurfaceAverage"] ? answer["plotsurfaceAverage"] : 0
          bid["avg_rooms"] = answer["roomsAverage"] ? answer["roomsAverage"] : 0
          bid["avg_date"] = answer["days"] ? answer["days"] : 0

          # Set average price depending on the closest area if Toulouse
          if @city_id == 1
            set_average_price(@bids, areas)
          # Set average price obtained from bids if Marseille
          elsif @city_id == 2
            bid["avg_price"] = answer["average"] ? answer["average"] : 0
          end

          # Set average price per surface if values exist
          if bid["price"] && bid["surface"]
            bid["price_per_sq_m"] = bid["price"].to_f / bid["surface"]
            # Internal rate return depending on reselling price and notarial costs
            bid["return"] = ((bid["avg_price"] - bid["price_per_sq_m"] - bid["avg_price"] * 0.025 - bid["price_per_sq_m"] * 0.2 * 0.03).to_f / bid["price_per_sq_m"])
          else
            bid["price_per_sq_m"] = 0
            bid["return"] = 0
          end
          create_flat(bid)
        end
      end
    end
  end


  # Task to update the database with a POST request to API Property Hub Staging
  def perform
    @zipcodes = set_zipcodes
    API_request(@zipcodes)
  end
end
