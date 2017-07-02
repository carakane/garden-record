class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      flash[:message] = "You already have an account"
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
      flash[:message] = "You are already logged in"
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
    else
      flash[:message] = "Please try again"
      redirect '/users/login'
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
        if @user == current_user
          erb :'/users/index'
        else
          flash[:message] = "You may only view your own homepage"
          redirect "/users/#{current_user.username}"
        end
      else
        flash[:message] = "Please Log In"
        redirect :'/login'
      end
  end

  get '/users/:username/edit' do
    if logged_in?
      @user = User.find_by(:username => params[:username])
      if @user.id == current_user.id
        erb :'/users/user_edit'
      else
        flash[:message] = "You may only edit your own homepage"
        redirect "/users/#{current_user.username}"
      end
    else
      flash[:message] = "Please Log In"
      redirect :'/login'
    end
    end
  end

  patch '/users/:username/edit' do
    ## unnecessary code?
    if logged_in?
      @user = User.find_by(:id => params["id"])
      # binding.pry
      if @user.id == current_user.id && @user.authenticate(params["user"]["password"])
        @user.update(params["user"])
          redirect "/users/#{@user.username}"
      else
        redirect "/users/#{@user.username}"
      end
    end
  end

  get '/users/:username/password' do
    if logged_in?
      @user = User.find_by(:username => params[:username])
      if @user.id == current_user.id
        erb :'/users/password'
      else
        redirect "/users/#{current_user.username}/password"
      end
    else
      flash[:message] = "Please Log In"
      redirect :'/login'
    end
  end

  patch '/users/:username/password' do
    ## unnecessary code?
    if logged_in?
      @user = User.find_by(:id => params["id"])
      if @user.id == current_user.id && @user.authenticate(params["user"]["password"])
        @user.update(:password => params["user_password"])
          redirect "/users/#{@user.username}"
      else redirect "/users/#{@user.username}"
      end
    end
  end


  delete '/users/:username/delete' do
    ##unnecessary code?
    if logged_in?
      @user = User.find_by(:id => params["id"])
      if @user.id == current_user.id && @user.authenticate(params["user"]["password"])
        @user.delete
        session.clear
        redirect "/"
      else redirect "/users/#{@user.username}"
      end
    end
  end

end
