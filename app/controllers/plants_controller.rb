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
    redirect "/plants/#{@plant.id}"
  end

  get '/plants/:id' do
    @user = current_user
    @plant = Plant.find_by(:id => params[:id])
    erb :'/plants/show'
  end

end
