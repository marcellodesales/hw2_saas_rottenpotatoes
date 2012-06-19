require 'spec_helper'

describe Movie do
  describe 'creating movie from the factory' do
    it 'should include rating and year' do
      movie = FactoryGirl.build(:movie, :title => 'Milk', :director => "Marcello")
      #etc.
      puts movie.to_search_param
      assert "director=Marcello&title=Milk" == movie.to_search_param

    end
  end
end
