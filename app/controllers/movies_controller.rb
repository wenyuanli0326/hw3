# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # controller using the same name with html file
  def show_by_director
    @movie = Movie.find(params[:id])

    if @movie.director.present?
      @movies_with_same_director = Movie.search_movies_by_director @movie.id
    # director: @movie.director).where.not(id: @movie.id)
    #        @movies = Movie.find_with_same_director(@movie.id)

    # if @movies_with_same_director == nil or @movies_with_same_director.empty?
    #     flash[:notice] = "Sorry, no movies with same director."
    #     redirect_to movies_path
    # else
    #     #redirect_to find_same_director_path

    # end
    else
      flash[:notice] = "#{@movie.title} has no director info"
      redirect_to movies_path
    end
  end

  private

  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
