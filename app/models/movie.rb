require "addressable/uri"

class Movie < ActiveRecord::Base

  def to_search_param
    uri = Addressable::URI.new
    uri.query_values = {:director => self.director, :title => self.title}
    uri.query
  end

  class InvalidKeyError < Error
  end
  class MovieNotFoundError < Error
  end 
end

def Movie.all_ratings
  ['G','PG','PG-13','R']
end

def Movie.find_in_tmdb(title)
  raise Movie::InvalidKeyError.new if !Tmdb || !Tmdb.api_key
  begin
    movieFound = TmdbMovie.find(:title => title, :limit => 1)
    raise Movie::MovieNotFoundError.new if movieFound.size == 0

    directorName = nil
    movieFound.cast.each{ |person|
      if person.job == "Director"
        directorName = person.name
        break
      end
    }

    Movie.new(:title => movieFound.name, :director => directorName, 
      :rating => movieFound.certification, :release_date => movieFound.released)

  rescue RuntimeError => re
    raise Movie::InvalidKeyError.new
  end
end
