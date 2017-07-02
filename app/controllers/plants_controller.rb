class PlantsController < ApplicationController

  get '/plants' do
    if logged_in?
      @plants = Plant.all
      erb :'/plants/index'
    else redirect '/login'
    end
  end

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
    if params["location_name"]
      # binding.pry
      @user = current_user
      @location = Location.create(:name => params["location_name"])
      @user.locations << @location
      @location.plants << @plant
    end
    redirect "/plants/#{@plant.id}"
  end

  get '/plants/:id' do
    @user = current_user
    @plant = Plant.find_by(:id => params[:id])
    erb :'/plants/show'
  end

  get '/plants/:id/edit' do
    @plant = Plant.find_by(:id => params[:id])
    erb :'/plants/edit_plant'
  end

  patch '/plants/:id/edit' do
    @plant = Plant.find_by(:id => params[:id])
    @plant.update(:name => params["plant_name"])
    redirect "/plants/#{@plant.id}"
  end

  delete '/plants/:id/delete' do
    @user = current_user
    @plant = Plant.find_by(:id => params[:id])
    @plant.delete
    redirect "/users/#{@user.username}"
  end


end
