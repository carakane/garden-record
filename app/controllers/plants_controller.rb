class PlantsController < ApplicationController

  get '/plants/new' do
    if logged_in?
      @user = current_user
      erb :'/plants/new_plant'
    else redirect '/login'
    end
  end

  post '/plants/new' do
    # binding.pry
    @plant = Plant.create(params["plant"])
    if params["location"]
      # binding.pry
      @location = Location.find_by(:id => params["location"])
      @location.plants << @plant
    end
    redirect "/plants/#{@plant.id}"
  end

  get '/plants/:id' do
    @user = current_user
    @plant = Plant.find_by(:id => params[:id])
    erb :'/plants/show'
  end

end
