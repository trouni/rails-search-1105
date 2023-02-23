class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # # /movies?query=Batman
      # params[:query]

      # ========
      # PgSearch
      # ========

      ## Without multisearch
      @movies = Movie.search(params[:query])

      ## With multisearch
      # @movies = PgSearch.multisearch(params[:query])

      ## Further filtering of results
      # @movies = @movies.where('price <= ?', params[:max_price]) if params[:max_price].present?
      # @movies = @movies.where('price >= ?', params[:min_price]) if params[:min_price].present?
      # @movies = @movies.near(params[:location], params[:radius] || 5) if params[:location].present?

      # ==================
      # Plain ActiveRecord
      # ==================

      # sql_query = <<~SQL
      #   movies.title @@ :q
      #   OR movies.synopsis @@ :q
      #   OR directors.first_name @@ :q
      #   OR directors.last_name @@ :q
      # SQL

      # @movies = Movie.joins(:director).where(sql_query, q: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end
