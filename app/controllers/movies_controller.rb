class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Load all the ratings from the model
    @all_ratings = Movie.all_ratings

    # figure out which ratings were selected by the user, if any.
    if params.has_key?(:ratings)
      session[:sel_ratings] = params[:ratings].keys

    elsif params.has_key?(:commit)
      session[:sel_ratings] = []
    end

    in_ratings = nil
    @sel_ratings = session[:sel_ratings]
    if @sel_ratings && @sel_ratings.size > 0
      in_ratings = @sel_ratings.map{|rat| "'#{rat}'"}.join(',')
    end

    @by_column = nil
    @by_column = session[:sort_column] if session.has_key?(:sort_column)
    if params.has_key?(:s)
      @by_column = params[:s]
      session[:sort_column] = params[:s]
    end

    # redirect the user to the URL built from the session
    redirect_map = {}
    if !params.has_key?(:s) && session.has_key?(:sort_column)
      redirect_map[:s] = session[:sort_column]
    end
    if !params.has_key?(:ratings) && session.has_key?(:sel_ratings)
      session[:sel_ratings].each{ |rat|
        redirect_map["ratings_#{rat}"] = "1"
      }
    end
    if redirect_map.size > 0 && !params.has_key?(:redirected)
      redirect_map[:redirected] = 1
      redirect_to movies_path(redirect_map)
    end

    if @by_column == "title_header"
      @movies = Movie.where("rating IN (#{in_ratings})").order("title").all if in_ratings
      @movies = Movie.order("title").all if !in_ratings

    elsif @by_column == "release_date_header"
      @movies = Movie.where("rating IN (#{in_ratings})").order("release_date").all if in_ratings
      @movies = Movie.order("release_date").all if !in_ratings

    else
      @movies = Movie.where("rating IN (#{in_ratings})").all if in_ratings
      @movies = Movie.all if !in_ratings
    end
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

  # add to movies_controller.rb, anywhere inside
  #  'class MoviesController < ApplicationController':
  def search_tmdb
    Movie.find_in_tmdb(params[:search_terms])  
  end

end
