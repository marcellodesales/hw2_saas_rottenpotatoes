require "addressable/uri"

class Movie < ActiveRecord::Base

  #def to_param
  #  "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}-#{director.gsub(/[^a-z0-9]+/i, '-')}"
  #end

  def to_search_param
    uri = Addressable::URI.new
    uri.query_values = {:director => self.director, :title => self.title}
    uri.query
  end

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
