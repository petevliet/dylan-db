class AlbumsController < ApplicationController

  def index
    @albums = Album.all.order(:release_date)
    @show_pages = @albums.count / 12 + 1
    # @albums.each do |record|
    #   url = URI.parse(record.image_url)
    #   res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') {|http| http.get(url.request_uri)}
    #   record.image_url = res['location']
    #   record.save
    # end
  end

  def show
    @album = Album.find(params[:id])
    if @album.tracks.length == 0
      @dylan_lookup = MusicGrabber.new
      @dylan_lookup.get_album(@album.album_num)
    end
    @album_tracks = @album.tracks.order(:track_id)
    # if @album.title.includes
    @year = @album.release_date.strftime("%Y").to_i
  end

end
