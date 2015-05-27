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
    # RapGenius query returns songs from different artists, make sure only Dylan's version shows
    dylan_version = []
    songs.each do |song|
      if song.artist.name == "Bob Dylan"
        dylan_version << song
      end
    end
    lyrics_raw = dylan_version[0].response["lyrics"]["plain"]
    # replace newspace markup with close->open p tags so lyrics can be displayed properly
    # also, if there are chorus tags, put 'verse' in front of first one so upcoming verse split works properly
    lyrics_html = lyrics_raw.split("\n").join("</p><p>").sub("[Chorus]", "[Verse Chorus]")
    track.lyrics = lyrics_html
    # split lyrics text into verses and save it in track.verses array
    verse_split = lyrics_html.split("[Verse ")
      verse_split.delete_if {|verse_element| verse_element.empty?}
    verse_split.each do |verse|
      if verse.match(/\A[0-9]/) != nil
        verse.prepend("[Verse ")
      else
        verse.prepend("[")
      end
      track.verses << verse
    end
    # if lyrics include a tagged chorus, the first chorus' contents must be preserved while subsequent chorus tags removed from lyrics so lyrics can be properly commented upon.
    # if track.lyrics.include?("Chorus]")
    #   first_chorus_index = track.verses.index{|verse| verse.include?("Chorus")}
    #   chorus = track.verses.slice!(first_chorus_index)
    #   track.verses.each {|verse| verse.slice!("[Chorus]")}
    #   track.verses.insert(first_chorus_index, chorus)
    # end
    track.lyrics.sub("[Verse Chorus]", "[Chorus]")
    track.save
  end


end
