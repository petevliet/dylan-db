class LyricsGrabber

  def initialize

  end

  def get_lyrics(track)
    # if title has tags that inhibit lyric api calls, remove them
    if track.title.include?("Remastered" || "Live" || "Single")
      song_title = track.title.slice(/\A[^(]+/).strip
    else
      song_title = track.title
    end
    songs = RapGenius.search_by_title(song_title)
    # RapGenius query returns songs from different artists, make sure only Dylan's versions show
    dylan_version = []
    songs.each do |s|
      if s.artist.name == "Bob Dylan"
        dylan_version << s
      end
    end
    lyrics_raw = dylan_version[0].response["lyrics"]["plain"]
    # replace newspace markup with close->open p tags so lyrics can be displayed properly
    @lyrics = lyrics_raw.split("\n").join("</p><p>")
    track.lyrics = @lyrics
    binding.pry
    track.save
  end


end
