class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @user = current_user
      @books = Book.all
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
      @book = Book.create(title: params[:title], author: params[:author], description: params[:description])
      redirect to "/books/#{@book.id}"
  end


  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    if @book
      if logged_in? && @book.user_id == current_user.id
        erb :'/books/show'
      else
        redirect to '/books'
      end
    else
      redirect to '/books'
    end
  end

  get '/books/:id/edit' do
    @book = Book.find_by_id(params[:id])
    if logged_in? && @book.user_id == current_user.id
      erb :'/books/edit'
    else
      redirect to '/'
    end
  end

  patch '/books/:id' do
    if params[:title] == ""
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find_by_id(params[:id])
      @book.update(title: params[:title], author: params[:author], description: params[:description])
      redirect to "/books/#{params[:id]}"
    end
  end

  delete '/books/:id/delete' do
    @book = Book.find_by_id(params[:id])
    if logged_in? && @book.user_id == current_user.id
      @book.delete
      redirect to '/books'
    else
      redirect to '/books'
    end
  end

end
