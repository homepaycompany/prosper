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
    zipcodes.each do |zipcode|
    # zipcodes.each do |zipcode|
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = { "City": City.where("zip_code like ?", "%#{zipcode}%").first.name,"ZipCode": zipcode,"DateFrom":"0001-01-01T00:00:00","DateTo":"9999-12-31T23:59:59.9999999" }.to_json
        res = http.request req
        answer = JSON.parse(res.body)
        property_types = ["apartment", "house"]
        @bids = answer["bids"].select{|bid| property_types.any? {|property_type| bid["propertyType"] == property_type}}.reject{|bid| bid['surface'] == 0}
      end
    end
    @bids
  end

  # Task to clean the database with a POST request to API Property Hub Staging
  def perform
    @flats = Flat.all
    @zipcodes = set_zipcodes
    @bids = API_request(@zipcodes)
    @flats.each do |flat|
      if @bids.select{|bid| bid['origin'] == flat['origin']}.count == 0
        flat.destroy
      end
    end
    return Flat.where(surface: 0).count
  end
end
