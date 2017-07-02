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
    if params["location_name"]
      # binding.pry
      @user = current_user
      @location = Location.create(:name => params["location_name"])
      @user.locations << @location
      @location.plants << @plant
    end
    flash[:message] = "You have added #{@plant.name}"
    redirect "/plants/#{@plant.slug}"
  end

  get '/plants/:slug' do
    if logged_in?
      @user = current_user
      # binding.pry
      @plant = Plant.find_by_slug(params[:slug])
      erb :'/plants/show'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  get '/plants/:slug/edit' do
    if logged_in?
      @plant = Plant.find_by_slug(params[:slug])
      @user = current_user
      erb :'/plants/edit_plant'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  patch '/plants/:slug/edit' do
    @plant = Plant.find_by_slug(params[:slug])

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
    redirect "/plants/#{@plant.slug}"
  end

  delete '/plants/:slug/delete' do
    @user = current_user
    @plant = Plant.find_by_slug(params[:slug])

    @plant_location = PlantLocation.where(:plant_id => @plant)
    @plant_location.each do |entry|
      entry.delete
    end

    flash[:message] = "You have deleted #{@plant.name}"
    @plant.delete
    redirect "/users/#{@user.username}"
  end

end
