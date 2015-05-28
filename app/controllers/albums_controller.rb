class AlbumsController < ApplicationController

  def index
    @albums = Album.all.order(:release_date)
    # @albums.each do |record|
    #   record.image_url = "https://partner.api.beatsmusic.com/v1/api/albums/#{record.album_num}/images/default?client_id=#{ENV['BEATS_API_KEY']}"
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
  end

end
