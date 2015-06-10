class LyricsGrabber

  def initialize()
    @song_lyrics = Lyricfy::Fetcher.new
  end

  def find_lyrics(track)
    # if title has tags that inhibit lyric api calls, remove them
    if track.title.include?("Remastered") || track.title.include?("Live") || track.title.include?("Single")
      song_title = track.title.slice(/\A[^(]+/).strip
    else
      song_title = track.title
    end
    response = @song_lyrics.search "bob dylan", song_title
    lyrics_raw = response.body
    # replace newspace markup with close->open p tags so lyrics can be displayed properly
    # also, if there are chorus tags, put 'verse' in front of first one so upcoming verse split works properly
    lyrics_html = lyrics_raw.split("\\n").join("</p><p>")
    track.lyrics = lyrics_html
    # split lyrics text into verses and save it in track.verses array
    verse_split = lyrics_html.split("</p><p>")
    verse_split.each {|verse| verse.prepend("<p>")}
    verse_split.each {|verse| verse << "</p>" }
    verses_count = (verse_split.length / 4) + 1
    verses_count.times {|i| track.verses << verse_split.slice!(0,4)}
    track.verses.map {|verse| verse.join("")}
    track.verses.pop
    # track.verses.flatten
    track.save
  end
#     verse_split.each do |verse|
#       if verse.match(/\A[0-9]/) != nil
#         verse.prepend("[Verse ")
#       else
#         verse.prepend("[")
#       end
#       track.verses << verse
#     end
#     track.save
# end

end
