class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # # /movies?query=Batman
      # params[:query]

      sql_query = <<~SQL
        movies.title @@ :q
        OR movies.synopsis @@ :q
        OR directors.first_name @@ :q
        OR directors.last_name @@ :q
      SQL

      @movies = Movie.joins(:director).where(sql_query, q: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end
