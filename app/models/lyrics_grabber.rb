class LyricsGrabber

  def initialize

  end

  def get_lyrics(track)
    songs = RapGenius.search_by_title(track.title)
    dylan_version = []
    songs.each do |s|
      if s.artist.name == "Bob Dylan"
        dylan_version << s
      end
    end
    lyrics_raw = dylan_version[0].response["lyrics"]["plain"]
    @lyrics = lyrics_raw.split("\n").join("</p><p>")
    track.lyrics = @lyrics
    track.save
  end


end
