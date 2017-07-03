class PlantsController < ApplicationController

  get '/plants' do
    if logged_in?
      @user = current_user
      @plants = @user.plants
      erb :'/plants/index'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  get '/plants/new' do
    if logged_in?
      @user = current_user
      erb :'/plants/new_plant'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
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
    if params["location_name"] != ""
      # binding.pry
      @user = current_user
      @location = Location.create(:name => params["location_name"])
      flash[:message1] = "You have added #{@location.name}"
      @user.locations << @location
      @location.plants << @plant
    end
    flash[:message] = "You have added #{@plant.name}"
    redirect "/plants/#{@plant.id}"
  end

  get '/plants/:id' do
    if logged_in?
      @user = current_user
      @plant = Plant.find_by(:id => params[:id])
      erb :'/plants/show'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  get '/plants/:id/edit' do
    if logged_in?
      @plant = Plant.find_by(:id => params[:id])
      @user = current_user
      erb :'/plants/edit_plant'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  patch '/plants/:id/edit' do
    @plant = Plant.find_by(:id => params[:id])

    if params["plant_name"] != ""
      @plant.update(:name => params["plant_name"])
    end

    if params["locations"] != (@plant.locations)
      @plant.locations.clear
      @locations = Location.where(:id => params["locations"])
      @locations.each do |location|
        location.plants << @plant
      end
    end

    if params["location_name"] != ""
      @user = current_user
      @location = Location.create(:name => params["location_name"])
      @user.locations << @location
      @location.plants << @plant
    end

    flash[:message] = "You have edited #{@plant.name}"
    redirect "/plants/#{@plant.id}"
  end

  delete '/plants/:id/delete' do
    @user = current_user
    @plant = Plant.find_by(:id => params[:id])

    @plant_location = PlantLocation.where(:plant_id => @plant)
    @plant_location.each do |entry|
      entry.delete
    end

    flash[:message] = "You have deleted #{@plant.name}"
    @plant.delete
    redirect "/users/#{@user.username}"
  end

end
