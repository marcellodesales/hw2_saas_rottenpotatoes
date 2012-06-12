class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    ratings = nil
    if params.has_key?(:ratings)
      ratings = params[:ratings].keys.map{|s| "'#{s}'"}.join(',')
    end
    if params.has_key?(:s)
      if params[:s] == "title_header"
      	@movies = Movie.where("rating IN (#{ratings})").order("title").all if ratings
      	@movies = Movie.order("title").all if !ratings

      elsif params[:s] == "release_date_header"
      	@movies = Movie.where("rating IN (#{ratings})").order("release_date").all if ratings
      	@movies = Movie.order("release_date").all if !ratings

      else
      	@movies = Movie.where("rating IN (#{ratings})").all if ratings
      	@movies = Movie.all if !ratings
      end

    else  
      @movies = Movie.where("rating IN (#{ratings})").all if ratings
      @movies = Movie.all if !ratings
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

end
