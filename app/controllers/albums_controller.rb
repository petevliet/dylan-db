class AlbumsController < ApplicationController

  def index
    @albums = Album.all.order(:release_date)
    @show_pages = @albums.count / 12 + 1

    # @albums.each do |record|
    #   record.large_image_url = "https://partner.api.beatsmusic.com/v1/api/albums/#{record.album_num}/images/default?size=large&client_id=#{ENV['BEATS_API_KEY']}"
    #   record.save
    # end
    #
    # @albums.each do |record|
    #   url = URI.parse(record.image_url)
    #   res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') {|http| http.get(url.request_uri)}
    #   record.image_url = res['location']
    #   record.save
    # end
    #
    # @albums.each do |record|
    #   url = URI.parse(record.large_image_url)
    #   res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') {|http| http.get(url.request_uri)}
    #   record.large_image_url = res['location']
    #   record.save
    # end
    #
    # @albums.each do |record|
    #   review_finder = MusicGrabber.new
    #   review_finder.get_review(record.album_num)
    # end
  end

  def show
    @album = Album.find(params[:id])
    if @album.tracks.length == 0
      @dylan_lookup = MusicGrabber.new
      @dylan_lookup.get_album(@album.album_num)
    end
    @album_tracks = @album.tracks.order(:track_id)
    @year = @album.release_date.strftime("%Y").to_i
    @album_comments = @album.tracks.inject(0) {|sum, track| sum + track.comments.length}
    if @album.album_review != "n/a"
      @review = @album.album_review.split("~")
      @author_and_source = @review[1].split(",")
    end
  end

end
