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
    @bids = []
    zipcodes.each do |zipcode|
    # zipcodes.each do |zipcode|
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = { "City": City.where("zip_code like ?", "%#{zipcode}%").first.name,"ZipCode": zipcode,"DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
        res = http.request req
        answer = JSON.parse(res.body)
        @bids << answer["bids"]
      end
    end
    @bids.flatten

  end

  def bids_filter(bids)
    # Exclude bids for houses and whose surface is nil
    property_type = "apartment"
    bids = bids.select{|bid| bid["propertyType"] == property_type}
    bids.reject!{|bid| bid['surface'] == 0}

    # Exclude bids for flats with no latitude
    bids.reject!{|bid| bid['latitude'] == 43.6041  && bid['longitude'] == 1.44067}

    # Exclude from bids, flats which have already been recorded
    urls = Flat.all.map{|flat| flat.url}
    bids.reject!{|bid| urls.include?(bid['url'])}
  end

  # Task to clean the database with a POST request to API Property Hub Staging
  def perform
    zipcodes = set_zipcodes
    bids = API_request(zipcodes)
    bids = bids_filter(bids)
    urls = Flat.all.map{|flat| flat.url}
    bid_urls = bids.map{|bid| bid["url"]}

    urls.each do |url|
      if !bid_urls.include?(url)
        Flat.find_by(url: url).destroy
      end
    end
  end
end
