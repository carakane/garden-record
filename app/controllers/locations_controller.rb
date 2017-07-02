class LocationsController < ApplicationController

  get '/locations' do
    if logged_in?
      @locations = Location.all
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

end
