require 'rails_helper'

RSpec.describe Movie, type: :model do
  before(:all) do
    if Movie.where(:title => "Big Hero 6").empty?
      Movie.create(:title => "Big Hero 6", 
                   :rating => "PG", :release_date => "2014-11-07")
    end
    
    # TODO(student): add more movies to use for testing
    if Movie.where(:title => "The Shawshank Redemption").empty?
      Movie.create(:title => "The Shawshank Redemption",
                   :rating => "PG", :release_date => "1994-11-07",
                   :director => "Frank Darabont")
    end
    
    if Movie.where(:title => "The Green Mile").empty?
      Movie.create(:title => "The Green Mile",
                   :rating => "G", :release_date => "1999-3-10",
                   :director => "Frank Darabont")
    end
    
    if Movie.where(:title => "The Godfather").empty?
      Movie.create(:title => "The Godfather",
                   :rating => "PG", :release_date => "1972-5-30",
                   :director => "Francis Ford Coppoia")
    end
    
    if Movie.where(:title => "Apocalypse Now").empty?
      Movie.create(:title => "Apocalypse Now",
                   :rating => "G", :release_date => "1979-10-08",
                   :director => "Francis Ford Coppoia")
    end
    
  end
  
  describe "others_by_same_director method" do
    it "returns all other movies by the same director"
      # TODO(student): implement this test
    
    it "does not return movies by other directors"
      # TODO(student): implement this test
  end
end


