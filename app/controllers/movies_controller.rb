class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	sort_selector = params[:sort_by]
	#@checked_ratings = params[:ratings]
	#@all_ratings = Movie.all_ratings
	case sort_selector
	when "title"
		order = {:order => "title"}
		@title_header = "hilite"
	when "release_date"
		order = {:order => "release_date"}
		@release_date_header = "hilite"
	end
		
	#if @checked_ratings == {}
	#	@checked_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
	#end
	@movies = Movie.find(order)
	#@movies = Movie.find_all_by_rating(@checked_ratings.keys, order)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
