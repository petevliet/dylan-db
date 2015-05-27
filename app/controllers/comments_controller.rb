class CommentsController < ApplicationController

  def new
    @album = Album.find(params[:album_id])
    @track = Track.find(params[:track_id])
    @comment = Comment.new
  end

  def create
    @album = Album.find(params[:album_id])
    @comment = Comment.new(comment_params)
    @comment.track_id = Track.find(params[:track_id]).id
    if @comment.save
      redirect_to album_track_path(@album, @comment.track_id)
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:user_id, :track_id, :annotation, :created_at)
  end

end
