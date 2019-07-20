require 'sinatra'

class ApplicationController < Sinatra::Base
require 'rack-flash'

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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login"
      end
    end

  end


end
