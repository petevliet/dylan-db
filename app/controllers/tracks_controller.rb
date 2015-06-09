class TracksController < ApplicationController

  def index
    @albums = Album.all.select {|album| album.types[0] == "studio" || album.types[1] == "studio" || album.id == 1 }
    tracks = []
    @albums.each do |album|
      tracks << album.tracks
    end
    biograph_tracks = Track.all.select {|track| track.title == "Percy's Song" || track.title == "Mixed-Up Confusion" || track.title == "Groom's Still Waiting At The Altar" || track.title == "Jet Pilot" || track.title == "Lay Down Your Weary Tune" || track.title == "Quinn The Eskimo (The Mighty Quinn)" || track.title == "Abandoned Love" || track.title == "Can You Please Crawl Out Your Window?" || track.title == "Positively 4th Street" || track.title == "Caribbean Wind" || track.title == "Up To Me" || track.title == "Baby, I'm In The Mood For You" || track.title == "I Wanna Be Your Lover"}
    tracks << biograph_tracks
    all_tracks = tracks.flatten

    @letters_array = ('A'..'Z').to_a
    @letters_hash = Hash.new {|k, v| k[v] = []}
    @letters_array.each do |letter|
    all_tracks.each do |track|
        if track.title.start_with?(letter)
          @letters_hash[letter] << track
        end
      end
      @letters_hash[letter]
    end
    # @unique_songs = Hash.new { |k,v| k[v] = []}
    # # letters_hash.each do |song_list|
    #   hash_name = song_list[0]
    #   songs_length = song_list.length - 1
    #   hash_name = Hash.new([])
    #     # song_list[1..songs_length][0].each do |song|
    #     #   hash_name["songs"] << [song.title, song.album_id, song.track_id]
    #     # end
    #   hash_name["songs"].each |song|
    #     song
    #   # end
    #   unique_songs_array = hash_name["songs"][0].uniq
    #   # @unique_songs[unique_songs_array[0]] << unique_songs_array
    # # end
  end

  def show
    @track = Track.find(params[:id])
    if @track.lyrics == nil
      @lyric_getter = LyricsGrabber.new
      @lyric_getter.get_lyrics(@track)
      if @track.lyrics == nil
        raise NotFound
      end
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
