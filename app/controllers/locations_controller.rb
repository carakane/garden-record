class LocationsController < ApplicationController

  get '/locations' do
    if logged_in?
      @user = current_user
      @locations = @user.locations
      erb :'/locations/index'
    else redirect '/login'
    end
  end

  get '/locations/new' do
    if logged_in?
      erb :'/locations/new_location'
    else redirect '/login'
    end
  end

  post '/locations/new' do
    # binding.pry
    @user = current_user
    @location = Location.create(params["location"])
    @user.locations << @location
    redirect "/locations/#{@location.id}"
  end

  get '/locations/:id' do
    @user = current_user
    @location = Location.find_by(:id => params[:id])
    erb :'/locations/show'
  end

    get '/locations/:id/edit' do
      @location = Location.find_by(:id => params[:id])
      erb :'/locations/edit_location'
    end

    patch '/locations/:id/edit' do
      @location = Location.find_by(:id => params[:id])
      @location.update(:name => params["location_name"])
      redirect "/locations/#{@location.id}"
    end

    delete '/locations/:id/delete' do
      @user = current_user
      @location = Location.find_by(:id => params[:id])

      @plant_location = PlantLocation.where(location_id => @location)
      @plant_location.each do |entry|
        entry.delete
      end

      @location.delete
      redirect "/users/#{@user.username}"
    end


end
