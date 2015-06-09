class TracksController < ApplicationController

  def show
    @track = Track.find(params[:id])
    if @track.lyrics == nil
      @lyric_getter = LyricsGrabber.new
      @lyric_getter.get_lyrics(@track)
    end
    @album_year = @track.album.release_date.strftime("%Y")
    @comments = Comment.where(track_id: @track.id)
    @comment = Comment.new
  end

  def new_comment
    @comment = Comment.new
    @track = Track.find(params[:id])
    @verse = params[:verse].to_i
  end

end
