class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/users/:username"
    else
      erb :'/users/new_user'
    end
  end

  post '/signup' do
    @user = User.create(params["user"])
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params["username"])
    if @user.password == params["password"]
      session[:user_id] = @user.id
      redirect '/users/:username'
    end
  end

end
