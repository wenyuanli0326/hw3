# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before(:all) do
    if Movie.where(title: 'Big Hero 6').empty?
      Movie.create(title: 'Big Hero 6',
                   rating: 'PG', release_date: '2014-11-07')
    end

    # TODO(student): add more movies to use for testing
    if Movie.where(title: 'The Shawshank Redemption').empty?
      Movie.create(title: 'The Shawshank Redemption',
                   rating: 'PG', release_date: '1994-11-07',
                   director: 'Frank Darabont')
    end

    if Movie.where(title: 'The Green Mile').empty?
      Movie.create(title: 'The Green Mile',
                   rating: 'G', release_date: '1999-3-10',
                   director: 'Frank Darabont')
    end

    # if Movie.where(:title => "The Godfather").empty?
    #   Movie.create(:title => "The Godfather",
    #                :rating => "PG", :release_date => "1972-5-30",
    #                :director => "Francis Ford Coppoia")
    # end

    if Movie.where(title: 'Apocalypse Now').empty?
      Movie.create(title: 'Apocalypse Now',
                   rating: 'G', release_date: '1979-10-08',
                   director: 'Francis Ford Coppoia')
    end
  end

  describe 'Test the get :show function' do
    movie = Movie.create(title: 'The Godfather',
                         rating: 'PG', release_date: '1972-5-30',
                         director: 'Francis Ford Coppoia')

    it 'get the correct movie to @movie by using id' do
      get :show, params: { id: movie.id }
    end

    it 'render the show page' do
      get :show, params: { id: movie.id }
      expect(response).to render_template(:show)
    end

    Movie.find_by(title: 'The Godfather').destroy
    # movie.destroy  #this does not work
  end

  describe 'Test the get :index function' do
    it 'render the show page (show html)' do
      get :index # , params: {}
      expect(response).to render_template(:index)
    end
  end

  describe 'when trying to find movies by the same director' do
    it 'returns a valid collection when a valid director is present' do
      # TODO(student): implement this test
      # get :show_by_director, params:  {:movie => {:title => "The Godfather",
      #                           :rating => "PG", :release_date => "1972-5-30",
      #                           :director => "Francis Ford Coppoia"}}
      # expect(response).to redirect_to find_same_director_path
      # expect(assigns(:movies_with_same_director).title).to eq('Apocalypse Now')

      movie = Movie.create(title: 'The Godfather',
                           rating: 'PG', release_date: '1972-5-30',
                           director: 'Francis Ford Coppoia')
      get :show_by_director, params: { id: movie.id, movie: }
      # expect(response).to redirect_to find_same_director_path
      # expect([m.title for m in assigns(:movies_with_same_director){}]).to eq('Apocalypse Now')
      titleList = []
      assigns(:movies_with_same_director).each { |m| titleList << m.title }
      expect(titleList).to eq(['Apocalypse Now', 'The Conversation'])
      Movie.find_by(title: 'The Godfather').destroy
    end

    it 'redirects to index with a warning when no director is present' do
      # TODO(student): implement this test
      movie = Movie.create(title: 'noDirectorTest',
                           rating: 'PG', release_date: '1972-5-30')
      get :show_by_director, params: { id: movie.id, movie: }
      expect(response).to redirect_to movies_path
      expect(flash[:notice]).to match(/noDirectorTest has no director info/)
      Movie.find_by(title: 'noDirectorTest').destroy
    end
  end

  describe 'creates' do
    it 'movies with valid parameters' do
      get :create, params: { movie: { title: 'Toucan Play This Game', director: 'Armando Fox',
                                      rating: 'G', release_date: '2017-07-20' } }
      expect(response).to redirect_to movies_path
      expect(flash[:notice]).to match(/Toucan Play This Game was successfully created./)
      Movie.find_by(title: 'Toucan Play This Game').destroy
    end
  end

  describe 'edit' do
    it 'redirects to the edit page' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :edit, params: { id: movie.id }
      expect(response).to render_template(:edit)
      movie.destroy
    end
  end

  describe 'updates' do
    it 'redirects to the movie details page and flashes a notice' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { description: 'Critics rave about this epic new thriller. Watch as main characters Armando Fox ' \
                                                                 'and Michael Ball, alongside their team of TAs, battle against the challenges of ' \
                                                                 'a COVID-19-induced virtual semester, a labyrinthian and disconnected assignment ' \
                                                                 'stack, and the ultimate betrayal from their once-trusted ally: Codio exams.' } }

      expect(response).to redirect_to movie_path(movie)
      expect(flash[:notice]).to match(/Outfoxed! was successfully updated./)
      movie.destroy
    end

    it 'actually does the update' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      get :update, params: { id: movie.id, movie: { director: 'Not Nick!' } }

      expect(assigns(:movie).director).to eq('Not Nick!')
      movie.destroy
    end
  end

  describe 'destroy' do
    it 'actually delete the movie' do
      movie = Movie.create(title: 'Outfoxed!', director: 'Nick Mecklenburg',
                           rating: 'PG-13', release_date: '2023-12-17')
      expect  do
        delete :destroy, params: { id: movie.id }
      end.to change(Movie, :count).by(-1)
      expect(flash[:notice]).to match(/Movie 'Outfoxed!' deleted./)
      expect(response).to redirect_to movies_path
    end
  end
end
