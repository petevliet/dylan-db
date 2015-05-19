class WelcomeController < ApplicationController

  def index
    @albums = Album.all.order(:release_date)
  end

  def show

  end

end
