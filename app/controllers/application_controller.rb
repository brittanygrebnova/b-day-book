require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end
  
  get '/' do
    erb :index
  end
  
  get '/signup' do
    erb :signup
  end
  
  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user.save
      session[:user_id] = @user.id
    end
  end
  
  get '/login' do
    erb :login
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    session[:user_id] = @user.id
  end
  
end