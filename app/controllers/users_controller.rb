class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.username}"
    else
      erb :'/users/new_user'
    end
  end

  post '/signup' do
    @user = User.create(params["user"])
    session[:user_id] = @user.id
    redirect "/users/#{@user.username}"
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.username}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect "/users/#{@user.username}"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect :'/'
    end
  end

  get '/users/:username' do
    if logged_in?
        @user = User.find_by(:username => params[:username])
        if @user.id == current_user.id
          erb :'/users/index'
        end
      else
        redirect :'/login'
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

  patch '/users/:username/edit' do
    if logged_in?
      @user = User.find_by(:id => params["id"])
      if @user.id == current_user.id
        @user.update(params["user"])
          redirect "/users/#{@user.username}"
      end
    end
  end

  delete '/users/:username/delete' do
    if logged_in?
      @user = User.find_by(:id => params["id"])
      if @user.id == current_user.id
        @user.delete
        session.clear
        redirect "/index"
      end
    end
  end

end
