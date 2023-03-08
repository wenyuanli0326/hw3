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
    
    # if Movie.where(:title => "The Godfather").empty?
    #   Movie.create(:title => "The Godfather",
    #                :rating => "PG", :release_date => "1972-5-30",
    #                :director => "Francis Ford Coppoia")
    # end

    if Movie.where(:title => "The Conversation").empty?
      Movie.create(:title => "The Conversation",
                   :rating => "G", :release_date => "1974-5-11",
                   :director => "Francis Ford Coppoia")
    end
    
    if Movie.where(:title => "Apocalypse Now").empty?
      Movie.create(:title => "Apocalypse Now",
                   :rating => "G", :release_date => "1979-10-08",
                   :director => "Francis Ford Coppoia")
    end
    
  end
  
  describe "others_by_same_director method" do
    it "returns all other movies by the same director" do
      # TODO(student): implement this test
      movie = Movie.create(:title => "The Godfather",
        :rating => "PG", :release_date => "1972-5-30",
        :director => "Francis Ford Coppoia")

      titleList = []
      Movie.search_movies_by_director(movie.id).each{ |m| titleList << m.title}
      expect(titleList).to eq(['Apocalypse Now', 'The Conversation'])
      
      Movie.find_by(:title => "The Godfather").destroy
    end


    it "does not return movies by other directors" do 
      # TODO(student): implement this test
      movie = Movie.create(:title => "The Godfather",
        :rating => "PG", :release_date => "1972-5-30",
        :director => "Francis Ford Coppoia")

      titleList = []
      Movie.search_movies_by_director(movie.id).each{ |m| titleList << m.title}
      expect(titleList).to_not include(['The Green Mile'])
      
      Movie.find_by(:title => "The Godfather").destroy
    end
    
  end

end


