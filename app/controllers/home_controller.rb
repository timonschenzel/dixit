class HomeController < ApplicationController
  require 'flickraw'

  def index
    @games = Game.all(order: "name")
    @game = Game.new
    @game.rounds.build
    5.times do |number|
      @game.tags.build
    end
    @game.pictures.build
  end

  def show
    FlickRaw.api_key="c8571424fe7527f4da1079f8101be2f1"
    FlickRaw.shared_secret="df3c746e52ce390a"

    url=params[:url]
    @photos = flickr.photos.search(:tags => url, :per_page => 15)

    render :layout => false
  end
end
