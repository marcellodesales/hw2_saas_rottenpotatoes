class Movie < ActiveRecord::Base

  class InvalidKeyError < Error

  end 
end

def Movie.all_ratings
  ['G','PG','PG-13','R']
end

def Movie.find_in_tmdb(title)
  raise Movie::InvalidKeyError.new if !Tmdb.api_key
  begin
    TmdbMovie.find(:title => title, :limit => 1)
  rescue RuntimeError => re
    raise Movie::InvalidKeyError.new
  end
end
