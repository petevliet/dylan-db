class AlbumsController < ApplicationController

  def index
    @albums = Album.all.order(:release_date)
    @show_pages = @albums.count / 12 + 1

  end

  def show
    @album = Album.find(params[:id])
    # populate album tracks if there aren't any yet
    if @album.tracks.length == 0
      @dylan_lookup = MusicGrabber.new
      @dylan_lookup.get_album(@album.album_num)
    end
    @album_tracks = @album.tracks.order(:track_id)
    @year = @album.release_date.strftime("%Y").to_i
    # calculate number of total comments for all album's tracks
    @album_comments = @album.tracks.inject(0) {|sum, track| sum + track.comments.length}
    # prepare album review for display, if there is one
    if @album.album_review != "n/a"
      @review = @album.album_review.split("~")
      @author_and_source = @review[1].split(",")
    end
  end

end
