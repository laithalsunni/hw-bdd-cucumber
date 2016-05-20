# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Movie.create!(movie)
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body =~ /.*#{e1}.*#{e2}/
  
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #Movie.all_ratings.each do |rating|
  #uncheck "ratings[#{rating}]"
  #end
  #p rating_list
  rating_list.split.each do |rating|
  step %Q{I #{uncheck}check "ratings_#{rating}"}   
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movie_list = Movie.all
  #p movie_list
  movie_list.each { |movie| step %Q{I should see "#{movie.title}"}}
  #fail "Unimplemented"
end

Then /I should (not )?see the following movies: (.*)$/ do |not_see, movie_list|
  # Make sure that all the movies in the app are visible in the table
  movie_list.split(",").each do |movie|
    movie = movie.gsub(/["']/, '').strip
    #page.should have_content(movie)
    if not_see
      expect(page).to_not have_content(movie)
    else
      expect(page).to have_content(movie)
    end
    #fail "Unimplemented"
  end
end