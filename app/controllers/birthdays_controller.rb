class BirthdaysController < ApplicationController
  
  get '/birthdays' do
    redirect_if_not_logged_in
    @user = current_user
    @birthdays = @user.birthdays
    #binding.pry
    erb :'birthdays/index'
  end
  
  get '/birthdays/new' do
    redirect_if_not_logged_in
    erb :'birthdays/new'
  end
  
  post '/birthdays' do
    if params[:name].empty? || params[:date].empty?
      flash[:message] = "Please fill in all required information."
      redirect "/birthdays/new"
    else
      @birthday = Birthday.create(:name => params[:name], :date => params[:date])
      @birthday.user_id = current_user.id
      @birthday.save
      flash[:message] = "Successfully created birthday reminder."
      redirect "birthdays/#{@birthday.id}"
    end
  end
  
  get '/birthdays/:id' do
    redirect_if_not_logged_in
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id]
      erb :'birthdays/show'
    else
      redirect "/"
    end
  end
  
  get '/birthdays/:id/edit' do
    redirect_if_not_logged_in
    @birthday = Birthday.find(params[:id])
    erb :'birthdays/edit'
  end
  
  patch '/birthdays/:id' do
    @birthday = Birthday.find(params[:id])
    if @birthday.user_id == session[:user_id] && !params[:name].empty? && !params[:date].empty?
      @birthday.update(:name => params[:name], :date => params[:date])
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
  
  get '/logout' do
    session.clear
    if session.empty?
      erb :logout
    end
  end
  
end