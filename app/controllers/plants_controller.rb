class PlantsController < ApplicationController

  get '/plants/new' do
    if logged_in?
      erb :'/plants/new_plant'
    else redirect '/login'
    end
  end

  post '/plants/new' do
    # binding.pry
    @plant = Plant.create(params["plant"])
  end
end
