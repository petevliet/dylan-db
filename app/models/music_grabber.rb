class MusicGrabber

  def initialize
    @conn = Faraday.new(:url => 'https://partner.api.beatsmusic.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_dylan
    response = @conn.get do |req|
      req.url "v1/api/artists/ar3782/albums?"
      req.params['client_id'] = ENV['BEATS_API_KEY']
      # req.headers['Content-Type'] = 'application/json'
    end
  end

end
