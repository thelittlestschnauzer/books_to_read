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

  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    if @book
      if logged_in? && @book.user_id == current_user.id
        erb :'books/show'
      else
        redirect to '/books'
      end
    else
      redirect to '/books'
    end
  end

end
