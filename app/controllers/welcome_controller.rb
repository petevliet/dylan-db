class WelcomeController < ApplicationController

  def index
    @titles = []
    @dylan_lookup = MusicGrabber.new
    @dylan_albums = @dylan_lookup.get_dylan
    @albums = @dylan_albums["data"]
    @albums.each do |album|
      @titles << album["title"]
    end
  end

  def show

  end

end
