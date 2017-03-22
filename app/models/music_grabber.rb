class MusicGrabber

  def initialize
    @spotify_collection = Faraday.new(:url => 'https://api.spotify.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    @albums = []
  end

  def get_art_from_spotify
    dylan_albums = Album.all

    # response = @spotify_collection.get do |req|
    #   req.url "v1/artists/74ASZWbe4lXaubB36ztrGX/albums?limit=50"
    # end

    response = @spotify_collection.get do |req|
      req.url "v1/artists/74ASZWbe4lXaubB36ztrGX/albums?offset=18&limit=50"
    end
    # parsed_second_response = JSON.parse(second_response.body)
    # parsed_second_response["items"].each do |album|
    #   spotify_dylan_collection["items"].push(album)
    # end

    spotify_dylan_collection = JSON.parse(response.body)


    spotify_dylan_collection["items"].each do |spotify_album|
      p spotify_album
      dylan_albums.each do |db_album|
        if db_album.title == "Bob Dylan's Greatest Hits, Vol.2" || db_album.title == "Biograph" || db_album.title == "Greatest Hits, Vol.3" || db_album.title == "Dylan (Deluxe)"
          db_album.image_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Bob_Dylan_Barcelona.jpg/360px-Bob_Dylan_Barcelona.jpg"
          db_album.large_image_url = "https://c1.staticflickr.com/7/6155/6158417919_f8059f091c_b.jpg"
          db_album.save!
        elsif spotify_album["name"] == db_album.title
          db_album.image_url = spotify_album["images"][1]["url"]
          db_album.large_image_url = spotify_album["images"][0]["url"]
          db_album.save!
          p db_album
        elsif spotify_album["name"].include? db_album.title
          db_album.image_url = spotify_album["images"][1]["url"]
          db_album.large_image_url = spotify_album["images"][0]["url"]
          db_album.save!
        end
      end
      if spotify_album["name"] == "Dylan & The Dead"
        jerry_and_dylan = Album.find(61)
        jerry_and_dylan.image_url = spotify_album["images"][1]["url"]
        jerry_and_dylan.large_image_url = spotify_album["images"][0]["url"]
        jerry_and_dylan.save
      elsif spotify_album["name"] == "The Bootleg Series Volumes 1-3 (Rare And Unreleased) 1961-1991"
        bootleg_three = Album.find(1)
        bootleg_three.image_url = spotify_album["images"][1]["url"]
        bootleg_three.large_image_url = spotify_album["images"][0]["url"]
        bootleg_three.save
      elsif spotify_album["name"] == "Live 1966 \"The Royal Albert Hall Concert\" The Bootleg Series Vol. 4"
        bootleg_four = Album.find(30)
        bootleg_four.image_url = spotify_album["images"][1]["url"]
        bootleg_four.large_image_url = spotify_album["images"][0]["url"]
        bootleg_four.save
      elsif spotify_album["name"] == "The Bootleg Series, Vol. 5 - Bob Dylan Live 1975: The Rolling Thunder Revue"
        bootleg_five = Album.find(10)
        bootleg_five.image_url = spotify_album["images"][1]["url"]
        bootleg_five.large_image_url = spotify_album["images"][0]["url"]
        bootleg_five.save
      elsif spotify_album["name"] == "Another Self Portrait (1969-1971): The Bootleg Series Vol. 10 Sampler"
        bootleg_ten = Album.find(37)
        bootleg_ten.image_url = spotify_album["images"][1]["url"]
        bootleg_ten.large_image_url = spotify_album["images"][0]["url"]
        bootleg_ten.save
      elsif spotify_album["name"] == "The Essential (2014 Revised)"
        essential = Album.find(4)
        essential.image_url = spotify_album["images"][1]["url"]
        essential.large_image_url = spotify_album["images"][0]["url"]
        essential.save
      elsif spotify_album["name"] == "The Bootleg Volume 6: Bob Dylan Live 1964 - Concert At Philharmonic Hall"
        bootleg_six = Album.find(40)
        bootleg_six.image_url = spotify_album["images"][1]["url"]
        bootleg_six.large_image_url = spotify_album["images"][0]["url"]
        bootleg_six.save
      elsif spotify_album["name"] == "No Direction Home: Bootleg Volume 7 (Movie Soundtrack)"
        bootleg_seven = Album.find(14)
        bootleg_seven.image_url = spotify_album["images"][1]["url"]
        bootleg_seven.large_image_url = spotify_album["images"][0]["url"]
        bootleg_seven.save
      elsif spotify_album["name"] == "The Basement Tapes Sampler: The Bootleg Series, Vol. 11"
        bootleg_eleven = Album.find(17)
        bootleg_eleven.image_url = spotify_album["images"][1]["url"]
        bootleg_eleven.large_image_url = spotify_album["images"][0]["url"]
        bootleg_eleven.save
      end
    end
  end

end
