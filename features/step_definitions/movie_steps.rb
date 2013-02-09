# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(title: movie[:title], rating: movie[:rating], release_date: movie[:release_date])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.should match(Regexp.new("#{e1}.*#{e2}", Regexp::MULTILINE))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    if uncheck
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
end

Then /I should see all the movies/ do
  rows = find("table#movies tbody").all("tr")
  rows.count.should == 10
end

Then /I should see the following movies/ do |expected_movies_table|
  rows = find("table#movies").all("tr")
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip }}
  expected_movies_table.diff!(table)
end

Given /I uncheck all the ratings/ do
  find("form").all("input[type='checkbox']").each do |checkbox|
    node = checkbox.base.native.to_s.match(/id="(?<checkbox_id>(\w|_|-)+)"/)
    uncheck(node[:checkbox_id])
  end
end