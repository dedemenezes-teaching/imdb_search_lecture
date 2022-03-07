class Movie < ApplicationRecord
  belongs_to :director
  # searchkick => used for elastisearch

  ##########################
  ####### REAL DEAL! #######
  ####### PGSearch!  #######
  ##########################


  include PgSearch::Model

  multisearchable against: [:title, :synopsis]

  pg_search_scope :search_by_title_and_synopsis,
    against: [ :title, :synopsis ],
    using: {
    # @@ -> Full Text # batm
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  pg_search_scope :global_search,
    against: [ :title, :synopsis ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
