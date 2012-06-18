require 'spec_helper'

describe Movie do
  describe 'creating movie from the factory' do
    it 'should include rating and year' do
      movie = FactoryGirl.build(:movie, :title => 'Milk')
      #etc.
    end
  end
end
