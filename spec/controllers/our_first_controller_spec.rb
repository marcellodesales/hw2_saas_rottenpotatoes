require 'spec_helper'

describe MoviesController do
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_in_tmdb).with('hardware')
      post :search_tmdb, {:search_terms => 'hardware'}
    end

    it 'should select the Search Results template for rendering' do
      Movie.stub(:find_in_tmdb) # see the meaning on presentation 5.4
      post :search_tmdb, {:search_terms => 'hardware'}
      # response is the response object 
      response.should render_template('search_tmdb')
    end
  end
end
