class LocationsController < ApplicationController

  get '/locations' do
    if logged_in?
      @user = current_user
      @locations = @user.locations
      erb :'/locations/index'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  get '/locations/new' do
    if logged_in?
      erb :'/locations/new_location'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  post '/locations/new' do
    # binding.pry
    @user = current_user
    @location = Location.create(params["location"])
    @user.locations << @location
    flash[:message] = "You have created #{@location.name}"
    redirect "/locations/#{@location.slug}"
  end

  get '/locations/:id' do
    if logged_in?
      @user = current_user
      @location = Location.find_by(:id => params[:id])
      erb :'/locations/show'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  get '/locations/:id/edit' do
    if logged_in?
      @location = Location.find_by(:id => params[:id])
      erb :'/locations/edit_location'
    else
      flash[:message] = "Please Log In"
      redirect '/login'
    end
  end

  patch '/locations/:id/edit' do
    @location = Location.find_by(:id => params[:id])
    @location.update(:name => params["location_name"])
    flash[:message] = "You have edited #{@location.name}"
    redirect "/locations/#{@location.slug}"
  end

  delete '/locations/:id/delete' do
    @user = current_user
    @location = Location.find_by(:id => params[:id])

    @plant_location = PlantLocation.where(:location_id => @location.id)
    @plant_location.each do |entry|
      entry.delete
    end

    flash[:message] = "You have deleted #{@location.name}"
    @location.delete
    redirect "/users/#{@user.username}"
  end

end
