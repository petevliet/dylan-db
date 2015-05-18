class MusicGrabber

  def initialize
    @conn = Faraday.new(:url => 'https://partner.api.beatsmusic.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    @albums = []
  end

  def get_dylan
    response = @conn.get do |req|
      req.url "v1/api/artists/ar3782/albums?limit=80"
      req.params['client_id'] = ENV['BEATS_API_KEY']
    end

    his_albums = JSON.parse(response.body)
  end

  def get_album(album_name)
    response = @conn.get do |req|
      req.url "v1/api/albums/#{album_name}?"
      req.params['client_id'] = ENV['BEATS_API_KEY']
    end

    his_albums = JSON.parse(response.body)
  end

end
