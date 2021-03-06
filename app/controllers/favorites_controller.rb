class FavoritesController < ApplicationController

	def create
	  book = Book.find(params[:book_id]) #current_userだけだと、数がカウントされない
	  favorite = Favorite.new(user_id: current_user.id, book_id: book.id)
	  favorite.save
	  redirect_back(fallback_location: root_path)
	end

	def destroy
	  book = Book.find(params[:book_id])
	  favorite = current_user.favorites.find_by(book_id: book.id)
	  favorite.destroy
	  redirect_back(fallback_location: root_path)
	  # request.referer
	end


end


