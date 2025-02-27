class MoviesController < ApplicationController
  # READ: index
  def index
    @list_of_movies = Movie.order(created_at: :desc)
    render(template: "movie_templates/index")
  end

  # READ: show
  def show
    @the_movie = Movie.find_by(id: params.fetch("path_id"))
    render(template: "movie_templates/show")
  end

  # CREATE: new_form
  def new_form
    render(template: "movie_templates/new_form")
  end

  # CREATE: actually insert a new movie record
  def create
    # Required parameters (test provides these)
    input_title       = params.fetch("query_title")
    input_director_id = params.fetch("query_director_id")
    # Optional parameters, with defaults:
    input_year        = params.fetch("query_year", nil)
    input_duration    = params.fetch("query_duration", nil)
    input_description = params.fetch("query_description", "")
    input_image       = params.fetch("query_image_url", "")

    a_new_movie = Movie.new(
      title:        input_title,
      director_id:  input_director_id,
      year:         input_year,
      duration:     input_duration,
      description:  input_description,
      image:        input_image
    )

    a_new_movie.save
    redirect_to("/movies/#{a_new_movie.id}")
  end

  # UPDATE: edit_form
  def edit_form
    @the_movie = Movie.find_by(id: params.fetch("path_id"))
    render(template: "movie_templates/edit_form")
  end

  # UPDATE: actually update the existing record
  def update
    the_movie = Movie.find_by(id: params.fetch("path_id"))

    the_movie.title       = params.fetch("query_title", the_movie.title)
    the_movie.director_id = params.fetch("query_director_id", the_movie.director_id)
    the_movie.year        = params.fetch("query_year", the_movie.year)
    the_movie.duration    = params.fetch("query_duration", the_movie.duration)
    the_movie.description = params.fetch("query_description", the_movie.description)
    the_movie.image       = params.fetch("query_image_url", the_movie.image)

    the_movie.save
    redirect_to("/movies/#{the_movie.id}")
  end

  # DELETE
  def destroy
    the_movie = Movie.find_by(id: params.fetch("path_id"))
    the_movie.destroy if the_movie
    redirect_to("/movies")
  end
end
