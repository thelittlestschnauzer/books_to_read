class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @user = current_user
      @books = @user.books.all
      erb :'books/index'
    else
      redirect to '/'
    end
  end

  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      redirect to '/'
    end 
  end

  post '/books' do
    if params[:title] == ""
      redirect to '/books/new'
    else
      @book = current_user.books.create(title: params[:title], author: params[:author], description: params[:description])
      redirect to "/books/#{@book.id}"
    end
  end



end
