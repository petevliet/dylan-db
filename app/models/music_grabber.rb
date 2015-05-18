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
    his_albums["data"].each do |new_album|
      new_dylan_album = Album.new
      new_dylan_album.title = new_album["title"]
      new_dylan_album.release_date = new_album["release_date"]
      # new_dylan_album.tracks = new_album["tracks"].length
      new_dylan_album.album_id = new_album["id"]
      new_dylan_album.save
    end

  end

  def get_album(album_id)
    response = @conn.get do |req|
      req.url "v1/api/albums/#{album_id}?"
      req.params['client_id'] = ENV['BEATS_API_KEY']
    end

    dylan_album = JSON.parse(response.body)
    # dylan_album["data"]["refs"]["tracks"].each do |new_album_info|
    #   album_info = Track.new
  end

end
