class LocationsController < ApplicationController

  get '/locations/new' do
    if logged_in?
      erb :'/locations/new_plant'
    else redirect '/login'
    end
  end

  post '/locations/new' do
    # binding.pry
    @location = Location.create(params["location"])
  end
end
