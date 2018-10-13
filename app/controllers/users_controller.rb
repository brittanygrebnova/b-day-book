class UsersController < ApplicationController
  
  get '/signup' do
    erb :signup
  end
  
  post '/signup' do
    if User.find_by(:username => params[:username])
      flash[:message] = "Username is not available."
      redirect "/signup"
    elsif !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/birthdays"
    else
      flash[:message] = "Please fill out all required information."
      redirect "/signup"
    end
  end
  
  get '/login' do
    erb :login
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username], :email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/birthdays"
    else
      flash[:message] = "Invalid login credentials."
      redirect "/login"
    end
  end
  
end