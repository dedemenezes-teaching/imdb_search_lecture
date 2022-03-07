class MoviesController < ApplicationController

  def index
    # raise
    if params[:query].present?
      # Multiple columns
      # sql_query = 'title ILIKE :query OR synopsis ILIKE :query'
      # @movies = Movie.where(sql_query, query: "%#{params[:query]}%")

      # multiple models - association
      # sql_query = " \
      #   movies.title ILIKE :query \
      #   OR movies.synopsis ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "

      # PG Full-text Search
      # LIKE -> search for characters, order matter!
      # dog
      # dogs dogville

      # FULL TEXT
      # JUMP
      # jumping, jumps, jumped

      # FullSearch
      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.synopsis @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "

      # # jump -> jumping jumps jumped
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # @movies = Movie.search_by_title_and_synopsis(params[:query])

      # @movies = Movie.global_search(params[:query])
      @movies = PgSearch.multisearch(params[:query])
    else
      @movies = Movie.all
    end
  end
end
