class AlbumsController < ApplicationController

  def index
    @dylan_lookup = MusicGrabber.new
    @dylan_album = @dylan_lookup.get_album(params[:query])
    @album_info = @dylan_album["data"]
    @tracks = @album_info["refs"]["tracks"]
  end

  def show

  end

end
