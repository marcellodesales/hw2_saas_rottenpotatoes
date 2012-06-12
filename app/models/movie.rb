class Movie < ActiveRecord::Base
end

def Movie.all_ratings
  ['G','PG','PG-13','R']
end
