class ActorsController < ApplicationController
  # READ: index
  def index
    # Only the first 100 actors, sorted by creation desc
    @list_of_actors = Actor.order(created_at: :desc).limit(100)
    render(template: "actor_templates/index")
  end

  # READ: show
  def show
    the_id = params.fetch("path_id")
    @the_actor = Actor.find_by(id: the_id)

    # Optionally handle not found:
    # return redirect_to("/actors") unless @the_actor

    render(template: "actor_templates/show")
  end

  # CREATE: new form
  def new
    render(template: "actor_templates/new_form")
  end

  # CREATE: actually insert new actor record
  def create
    new_actor = Actor.new
    new_actor.name  = params.fetch("query_name")
    new_actor.dob   = params.fetch("query_dob")
    new_actor.bio   = params.fetch("query_bio")
    new_actor.image = params.fetch("query_image_url")

    if new_actor.valid?
      new_actor.save
      redirect_to("/actors/#{new_actor.id}")
    else
      render(template: "actor_templates/new_form")
    end
  end

  # UPDATE: edit form
  def edit
    the_id = params.fetch("path_id")
    @the_actor = Actor.find_by(id: the_id)

    render(template: "actor_templates/edit_form")
  end

  # UPDATE: actually update existing actor row
  def update
    the_id = params.fetch("path_id")
    the_actor = Actor.find_by(id: the_id)

    the_actor.name  = params.fetch("query_name")
    the_actor.dob   = params.fetch("query_dob")
    the_actor.bio   = params.fetch("query_bio")
    the_actor.image = params.fetch("query_image_url")

    if the_actor.valid?
      the_actor.save
      redirect_to("/actors/#{the_actor.id}")
    else
      @the_actor = the_actor  # needed so edit form has the existing data
      render(template: "actor_templates/edit_form")
    end
  end

  # DELETE
  def destroy
    the_id = params.fetch("path_id")
    the_actor = Actor.find_by(id: the_id)

    the_actor.destroy if the_actor.present?
    redirect_to("/actors")
  end
end
