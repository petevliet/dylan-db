class TracksController < ApplicationController

  def show
    @track = Track.find(params[:id])
    songs = RapGenius.search_by_title(@track.title)
    dylan_version = []
    songs.each do |s|
      if s.artist.name == "Bob Dylan"
        dylan_version << s
      end
    end
    lyrics_raw = dylan_version[0].response["lyrics"]["plain"].html_safe
    @lyrics = lyrics_raw.split("\n").join("</p><p>").html_safe
  end

end
