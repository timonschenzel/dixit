class GamesController < ApplicationController
  before_filter :signed_in_user, only: [:index]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @games = Game.paginate(page: params[:page])
  end

  def show
    @game = Game.find(params[:id])
    #@microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      # Get the first round form this new game
      current_round = @game.rounds.first
      # Create the storyteller for the first round of this game
      current_round.participants.create({user_id: current_user.id, is_storyteller: true})
      # Get the current storyteller
      storyteller = current_round.participants.first
      storyteller.pictures.create({ flickr_id: params[:flickr_id], round_id: current_round.id, is_start_picture: true })
      #@round = Round.new(game_id: @game.id, story_fragment: params[:new_round][:story_fragment])
      #@game.rounds.pictures.create(params[:new_picture][:flickr_id])
      flash[:success] = "Your game had been created, select a picture for the first round"

      FlickRaw.api_key="c8571424fe7527f4da1079f8101be2f1"
      FlickRaw.shared_secret="df3c746e52ce390a"

      @tags = "#{@game.category.name}, #{current_round.story_fragment.gsub(" ", ", ")}"
      @photos = flickr.photos.search(:tags => @tags, :per_page => 15)

      respond_to do |format|
        format.json { render :json => {
            :game => @game
          }
        }
      end
    else
      #render 'new'
    end
  end

  def invite
    @friends = current_user.friends
    @game = Game.find(params[:id])

    render :layout => false
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:success] = "Game updated"
      redirect_to root_path
    else
      #render 'edit'
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    flash[:success] = "Game destroyed."
    redirect_to root_path
  end

  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
