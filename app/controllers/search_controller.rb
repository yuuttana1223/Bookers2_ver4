class SearchController < ApplicationController
  def search
    model = params[:model]
    pattern_match = params[:pattern_match]
    @search_word = params[:search_word]

    case model
    when "book"
      @books = Book.search_for(pattern_match, @search_word)
    when "user"
      @users = User.search_for(pattern_match, @search_word)
    end
  end
end
