class TracksController < ApplicationController

  def index
    # only select studio albums, or Biogrpah and Bootleg1-3 have unreleased material
    @albums = Album.all.select {|album| album.types[0] == "studio" || album.types[1] == "studio" || album.title == "The Bootleg Series, Vols.1-3 (Rare And Unreleased) 1961-1991" || album.title == "Biograph" }
    tracks = []
    @albums.each do |album|
      unless album.id == 3
        tracks << album.tracks
      end
    end
    # select tracks from biograph that are unreleased
    biograph_tracks = Track.all.select {|track| track.title == "Percy's Song" || track.title == "Mixed-Up Confusion" || track.title == "Groom's Still Waiting At The Altar" || track.title == "Jet Pilot" || track.title == "Lay Down Your Weary Tune" || track.title == "Quinn The Eskimo (The Mighty Quinn)" ||
       track.title == "Abandoned Love" || track.title == "Can You Please Crawl Out Your Window?" || track.title == "Positively 4th Street" || track.title == "Caribbean Wind" || track.title == "Up To Me" || track.title == "Baby, I'm In The Mood For You" || track.title == "I Wanna Be Your Lover"}
    tracks << biograph_tracks

    all_tracks = tracks.flatten
    @alphabet_array = []
    @letters_array = ('A'..'Z').to_a
    @letters_hash = Hash.new {|k, v| k[v] = []}
    @letters_array.each do |letter|
      all_tracks.each do |track|
          if track.title.start_with?(letter)
            @letters_hash[letter] << track
          end
        end
        @alphabet_array << @letters_hash[letter].sort_by{|k,v| k["title"]}
      end
  end

  def show
    @track = Track.find(params[:id])
    if @track.lyrics == nil
      lyric_query = LyricsGrabber.new
      lyric_query.find_lyrics(@track)
    end
    if @track.lyrics == nil
      raise NotFound
    end
    @album_year = @track.album.release_date.strftime("%Y")
    @comments = Comment.where(track_id: @track.id).order(id: :desc)
    @comment = Comment.new
  end

  def new_comment
    @comment = Comment.new
    @track = Track.find(params[:id])
    @verse = params[:verse].to_i
  end

end
