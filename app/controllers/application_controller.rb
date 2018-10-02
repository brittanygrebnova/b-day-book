class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_birthday_wish"
    use Rack::Flash
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
      redirect "/birthdays"
    else
      redirect "/signup"
    end
  end
  
  get '/login' do
    erb :login
  end
  
  post '/login' do
    if User.find_by(:username => params[:username])
      @user = User.find_by(:username => params[:username])
      session[:user_id] = @user.id
      redirect "/birthdays"
    else
      erb :login
    end
  end
  
  get '/birthdays' do
    @user = current_user
    @birthdays = @user.birthdays
    erb :'birthdays/index'
  end
  
  get '/birthdays/new' do
    erb :'birthdays/new'
  end
  
  post '/birthdays' do
    @birthday = Birthday.create(:name => params[:name], :date => params[:date])
    @birthday.user_id = current_user.id
    @birthday.save
    flash[:message] = "Successfully created birthday reminder."
    redirect "birthdays/#{@birthday.id}"
  end
  
  get '/birthdays/:id' do
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id]
      erb :'birthdays/show'
    else
      redirect "/"
    end
  end
  
  get '/birthdays/:id/edit' do
    @birthday = Birthday.find(params[:id])
    erb :'birthdays/edit'
  end
  
  patch '/birthdays/:id' do
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id] && !params[:name].empty? && !params[:date].empty?
      @birthday.update(:name => params[:name], :date => params[:date]) 
      @birthday.save
    elsif @birthday.user_id == session[:user_id] && params[:name].empty? && !params[:date].empty?
      @birthday.update(:date => params[:date]) 
      @birthday.save
    elsif @birthday.user_id == session[:user_id] && !params[:name].empty? && params[:date].empty?
      @birthday.update(:name => params[:name])
      @birthday.save
    else
      erb :'birthdays/edit'
    end
    redirect "/birthdays/#{@birthday.id}"
  end
  
  delete '/birthdays/:id/delete' do
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id]
      @birthday.destroy
      redirect "/birthdays"
    end
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