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
end
