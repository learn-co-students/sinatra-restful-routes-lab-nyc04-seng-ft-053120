class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
    # displays all recipes in db, with link to each recipe show page
  end

  get '/recipes/new' do
    # render a form to create a new recipe
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
    # renders show.erb, showing a single recipe
  end

  post '/recipes' do
    # creates 1 recipe
    @recipe = Recipe.create(params)
    
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do
    # find the recipe by id
    @recipe = Recipe.find(params[:id])
    # renders edit.erb
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    @recipe.update(params)
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])

    redirect '/recipes'
  end
end
