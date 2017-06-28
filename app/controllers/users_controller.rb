class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/garden"
    else
      erb :'/users/new_user'
    end
  end

  post '/signup' do
    # binding.pry
    @user = User.create(params["user"])
  end



end
