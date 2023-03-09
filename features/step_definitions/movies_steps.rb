# frozen_string_literal: true

Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %(I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}")
  end
end

Then(/I should see all the movies/) do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %(I should see "#{movie.title}")
  end
end


When("I visit the edit page for {string}") do |title|
  movie = Movie.find_by(title: title)
  visit edit_movie_path(movie)
end

Then("the director of {string} should be {string}") do |title, director|
  movie = Movie.find_by(title: title)
  expect(movie.director).to eq(director)
end

# Scenario: find movie with same director
#   Given I am on the details page for "Star Wars"
#   When  I follow "Find Movies With Same Director"
#   Then  I should be on the Similar Movies page for "Star Wars"
#   And   I should see "THX-1138"
#   But   I should not see "Blade Runner"

When("I am now on the details page for {string}") do |title|
  movie = Movie.find_by(title: title)
  visit movie_path(movie)
end

Then("I should be now on the Similar Movies page for {string}") do |title|
  movie = Movie.find_by(title: title)
  visit find_same_director_path(movie)
end

Then(/^I should now see "'(.+)' has no director info"$/) do |title|
  expect(page).to have_content("#{title} has no director info")
end