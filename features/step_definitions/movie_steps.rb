# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end

  assert Movie.all.count == movies_table.hashes.size
  
end

# Make sure that one string (regexp) occurs before or after anotaer one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  movieTitles = page.all("table#movies tbody tr td[1]").map {|t| t.text}
  assert movieTitles.index(e1) < movieTitles.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
 rating_list.split(",").each do |rat|
    rat = rat.strip
    if uncheck == "un"
       step %Q{I uncheck "ratings_#{rat}"}
       step %Q{the "ratings_#{rat}" checkbox should not be checked}
    else
      step %Q{I check "ratings_#{rat}"}
      step %Q{the "ratings_#{rat}" checkbox should be checked}
    end
  end
end

Then /^I should see the following ratings: (.*)/ do |rating_list|
  ratingsInPage = page.all("table#movies tbody tr td[2]").map! {|t| t.text}
  rating_list.split(",").each do |rat|
    assert ratingsInPage.include?(rat.strip)
  end
end
