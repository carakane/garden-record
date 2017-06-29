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
    erb :'/users/index'
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

  get '/users/:username' do
    if logged_in?
        @user = User.find_by(:username => params[:username])
        if @user.id == current_user.id
          erb :'/users/index'
        end
      end
  end

  get '/users/:username/edit' do
    if logged_in?
      @user = User.find_by(:username => params[:username])
      if @user.id == current_user.id
        erb :'/users/user_edit'
      end
    end
  end

  delete '/users/:username/delete' do
    if logged_in?
      @user = User.find_by(:username => params[:username])
      if @user.id == current_user.id
        @user.delete
        erb :'/users/user_delete'
      end
    end
  end


end
