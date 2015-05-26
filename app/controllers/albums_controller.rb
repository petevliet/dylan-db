class AlbumsController < ApplicationController

  def index

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
