class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_birthday_wish"
  end
  
  get '/' do
    erb :index
  end
  
  get '/signup' do
    erb :signup
  end
  
  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    # if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user.save
      session[:user_id] = @user.id
      #binding.pry
      redirect "/birthdays"
    # end
  end
  
  get '/login' do
    erb :login
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    session[:user_id] = @user.id
    redirect "/birthdays"
  end
  
  get '/birthdays' do
    #binding.pry
    @user = current_user
    @birthdays = @user.birthdays
    erb :'birthdays/index'
    #binding.pry
  end
  
  get '/birthdays/new' do
    erb :'birthdays/new'
  end
  
  post '/birthdays' do
    @birthday = Birthday.create(:name => params[:name], :date => params[:birthdate])
    @birthday.user_id = current_user.id
    @birthday.save
    redirect "birthdays/#{@birthday.id}"
  end
  
  get '/birthdays/:id' do
    @birthday = Birthday.find(params[:id])
    erb :'birthdays/show'
  end
  
  patch '/birthdays/:id' do
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id]
      @birthday.update(:name => params[:name], :date => params[:date])   
      @birthday.save
    end
  end
  
  delete '/birthdays/:id/delete' do
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id]
      #binding.pry
      @birthday.destroy
    end
  end
  
  get '/birthdays/:id/edit' do
    erb :'birthdays/edit'
  end
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
  
  
end