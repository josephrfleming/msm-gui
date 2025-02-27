Rails.application.routes.draw do
  # MISCELLANEOUS / HOME
  get("/", { :controller => "misc", :action => "homepage" })

  # DIRECTORS
  get("/directors/youngest", { :controller => "directors", :action => "max_dob" })
  get("/directors/eldest",   { :controller => "directors", :action => "min_dob" })

  # READ
  get("/directors",          { :controller => "directors", :action => "index" })      # list
  get("/directors/:path_id", { :controller => "directors", :action => "show" })       # details

  # CREATE
  get("/directors/new",      { :controller => "directors", :action => "new_form" })   # blank form
  post("/insert_director",   { :controller => "directors", :action => "create" })      # create record

  # UPDATE
  get("/directors/:path_id/edit",   { :controller => "directors", :action => "edit_form" })
  post("/update_director/:path_id", { :controller => "directors", :action => "update" })

  # DELETE
  get("/delete_director/:path_id", { :controller => "directors", :action => "destroy" })


  # MOVIES
  # READ
  get("/movies",          { :controller => "movies", :action => "index" })
  get("/movies/:path_id", { :controller => "movies", :action => "show" })

  # CREATE
  get("/movies/new",      { :controller => "movies", :action => "new_form" })
  post("/insert_movie",   { :controller => "movies", :action => "create" })

  # UPDATE
  get("/movies/:path_id/edit",    { :controller => "movies", :action => "edit_form" })
  post("/update_movie/:path_id",  { :controller => "movies", :action => "update" })

  # DELETE
  get("/delete_movie/:path_id", { :controller => "movies", :action => "destroy" })


  # ACTORS
  # READ
  get("/actors",          { :controller => "actors", :action => "index" })
  get("/actors/:path_id", { :controller => "actors", :action => "show" })

  # CREATE
  get("/actors/new",      { :controller => "actors", :action => "new_form" })
  post("/insert_actor",   { :controller => "actors", :action => "create" })

  # UPDATE
  get("/actors/:path_id/edit",    { :controller => "actors", :action => "edit_form" })
  post("/update_actor/:path_id",  { :controller => "actors", :action => "update" })

  # DELETE
  get("/delete_actor/:path_id", { :controller => "actors", :action => "destroy" })
end
