class TracksController < ApplicationController

  def show
    @track = Track.find(params[:id])
    if @track.lyrics == nil
      @lyric_getter = LyricsGrabber.new
      @lyric_getter.get_lyrics(@track)
    end
    @album_year = @track.album.release_date.strftime("%Y")
  end

end
