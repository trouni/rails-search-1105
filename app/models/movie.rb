class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model
  multisearchable against: [:title, :synopsis]

  # pg_search_scope :name_of_my_search_method
  pg_search_scope :search,
    against: [ :title, :synopsis ],
    associated_against: {
      director: [ :first_name, :last_name ],
      # actors: [:first_name, :last_name] # for more tables
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
