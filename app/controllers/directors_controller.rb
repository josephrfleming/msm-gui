class DirectorsController < ApplicationController
  # READ: index
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  # READ: show
  def show
    the_id = params.fetch("path_id")
    @the_director = Director.find_by(id: the_id)
    render(template: "director_templates/show")
  end
  

  # CUSTOM ACTIONS FOR YOUNGEST / ELDEST
  def max_dob
    directors_by_dob_desc = Director.all.where.not({ :dob => nil }).order({ :dob => :desc })
    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.all.where.not({ :dob => nil }).order({ :dob => :asc })
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  # 1) CREATE: new_form
  #    Shows a blank form for adding a new Director
  def new_form
    render({ :template => "director_templates/new_form" })
  end

  # 2) CREATE: actually inserts a new director record
  def create
    input_name      = params.fetch("query_name")
    input_dob       = params.fetch("query_dob", "").strip
    input_dob       = input_dob.empty? ? nil : input_dob  # convert empty string to nil
    input_bio       = params.fetch("query_bio", "")
    input_image_url = params.fetch("query_image_url", "")
  
    new_director = Director.new(
      name:  input_name,
      dob:   input_dob,
      bio:   input_bio,
      image: input_image_url
    )
  
    if new_director.save
      redirect_to("/directors/#{new_director.id}")
    else
      render(template: "director_templates/new_form")
    end
  end
  
  
  

  # 3) UPDATE: edit_form
  #    Shows a pre-populated form for an existing Director
  def edit_form
    the_id = params.fetch("path_id")
    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/edit_form" })
  end

  # 4) UPDATE: actually update the record
  def update
    the_id = params.fetch("path_id")
    matching_directors = Director.where({ :id => the_id })
    the_director = matching_directors.at(0)

    # Grab the submitted form data
    the_director.name  = params.fetch("query_name")
    the_director.dob   = params.fetch("query_dob")
    the_director.bio   = params.fetch("query_bio")
    the_director.image = params.fetch("query_image_url")

    the_director.save

    # Redirect to the show page for this Director
    redirect_to("/directors/#{the_director.id}")
  end

  # 5) DESTROY
  def destroy
    the_id = params.fetch("path_id")
    matching_directors = Director.where({ :id => the_id })
    the_director = matching_directors.at(0)

    the_director.destroy

    # Redirect to the directors index
    redirect_to("/directors")
  end
end
