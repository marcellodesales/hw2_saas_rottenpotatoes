require 'spec_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    context 'with valid key' do
      it 'should call Tmdb with title keywords given valid API key' do
        Tmdb.api_key = "6ab5c7d848120954b255b916cf5d6b16" # received by email
        TmdbMovie.should_receive(:find).
          with(hash_including :title => 'Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid key' do
      it 'should raise InvalidKeyError if key not given' do
        Tmdb.api_key = nil
        Movie.stub(:api_key).and_return('')
        lambda { Movie.find_in_tmdb('Inception') }.
          should raise_error(Movie::InvalidKeyError)
      end
      it 'should raise InvalidKeyError if key is bad' do
        Tmdb.api_key = "Wrong key"
        TmdbMovie.stub(:find).
          and_raise(RuntimeError.new('API returned code 404'))
        lambda { Movie.find_in_tmdb('Inception') }.
          should raise_error(Movie::InvalidKeyError)
      end
    end
  end
end
